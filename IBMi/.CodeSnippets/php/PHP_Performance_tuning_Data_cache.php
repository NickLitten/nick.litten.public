<?php
declare(strict_types=1);

/**
 * PHP Performance Tuning - SHM Data Cache Demo
 *
 * Demonstrates Zend SHM cache, DB2 for i access, and SOAP currency conversion.
 * Credentials should be moved to a config file or environment variables.
 *
 * @author Nick Litten
 */

// ---------------------------------------------------------------------------
// Constants - move to config / environment in production
// ---------------------------------------------------------------------------
const DB2_DSN      = '*LOCAL';
const DB2_USER     = 'PHPUSER';
const DB2_PASS     = 'phpuser1';
const CURRENCY_XML = 'https://www.currency-iso.org/dam/downloads/table_a1.xml';
const SOAP_WSDL    = 'https://www.webservicex.net/currencyconvertor.asmx?WSDL';
const CACHE_KEY    = 'currencycodes';
const CACHE_TTL    = 10 * 3600; // 10 hours

// ---------------------------------------------------------------------------

/**
 * Returns ISO currency codes, optionally as HTML <option> elements.
 *
 * Results are cached in Zend SHM for CACHE_TTL seconds. On cache miss the
 * XML feed is fetched, parsed, and stored before returning.
 *
 * @param  string $style  'option' returns HTML option strings; anything else
 *                        returns ['Code' => ..., 'Country' => ...] arrays.
 * @return array|false    Populated array on success, false on failure.
 */
function getCurrencyCode(string $style = 'array'): array|false
{
    $cached = zend_shm_cache_fetch(CACHE_KEY);
    if ($cached !== null) {
        return $cached ?: false;
    }

    $xml = file_get_contents(CURRENCY_XML);
    if ($xml === false) {
        return false;
    }

    $simpleXML = simplexml_load_string($xml);
    if ($simpleXML === false) {
        return false;
    }

    $result = [];
    foreach ($simpleXML->CcyTbl->CcyNtry as $entry) {
        $ccy     = htmlentities((string) $entry->Ccy);
        $country = htmlentities((string) $entry->CtryNm);

        if ($ccy === '') {
            continue;
        }

        if ($style === 'option') {
            $selected = ($ccy === 'USD' && $country === 'UNITED STATES') ? ' selected' : '';
            $result[] = sprintf(
                ' <option value="%s"%s>%s - %s</option>' . "\n",
                $ccy,
                $selected,
                $ccy,
                $country
            );
        } else {
            $result[] = ['Code' => $ccy, 'Country' => $country];
        }
    }

    zend_shm_cache_store(CACHE_KEY, $result, CACHE_TTL);

    return $result ?: false;
}

// ---------------------------------------------------------------------------

/**
 * Fetches the conversion rate between two ISO currency codes via SOAP.
 *
 * @param  SoapClient $client    Pre-instantiated SOAP client (reuse across calls).
 * @param  string     $fromRate  ISO currency code to convert from.
 * @param  string     $toRate    ISO currency code to convert to.
 * @return float                 Conversion rate.
 */
function getCurrencyRate(SoapClient $client, string $fromRate, string $toRate): float
{
    $response = $client->ConversionRate([
        'FromCurrency' => $fromRate,
        'ToCurrency'   => $toRate,
    ]);

    return (float) $response->ConversionRateResult;
}

// ---------------------------------------------------------------------------

/**
 * Loads currency pairs from DB2, fetches live rates, updates the table,
 * and renders an HTML summary table.
 */
function loadRates(): void
{
    $conn = db2_connect(DB2_DSN, DB2_USER, DB2_PASS);
    if ($conn === false) {
        echo 'DB2 connection error ' . db2_conn_error() . ': ' . db2_conn_errormsg();
        return;
    }

    $sql  = 'SELECT FROMCURRENCY, TOCURRENCY FROM zenddata.rates';
    $stmt = db2_exec($conn, $sql);
    if ($stmt === false) {
        echo 'DB2 query error ' . db2_stmt_error() . ': ' . db2_stmt_errormsg();
        db2_close($conn);
        return;
    }

    // Prepare the UPDATE statement once; bind parameters for each row
    $updateSql  = 'UPDATE zenddata.rates SET CONVERSIONRATE = ?, CONVERTDATE = ? '
                . 'WHERE FROMCURRENCY = ? AND TOCURRENCY = ?';
    $updateStmt = db2_prepare($conn, $updateSql);

    // Instantiate SOAP client once outside the loop
    $soapClient = new SoapClient(SOAP_WSDL);
    $today      = date('m/d/Y');

    echo '<table border="2"><tr><th>From Currency</th><th>To Currency</th><th>Rate</th></tr>';

    while ($row = db2_fetch_assoc($stmt)) {
        $from = $row['FROMCURRENCY'];
        $to   = $row['TOCURRENCY'];
        $rate = getCurrencyRate($soapClient, $from, $to);

        db2_execute($updateStmt, [$rate, $today, $from, $to]);

        echo "<tr><td>{$from}</td><td>{$to}</td><td>{$rate}</td></tr>";
    }

    echo '</table>';

    db2_close($conn);
}
