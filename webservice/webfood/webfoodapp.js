const express = require('express');
const app = express();
const port = 8080;

app.use(express.json());  // Magic for parsing JSON bodies

// The endpoint – handles your incoming JSON
app.post('/api/food', (req, res) => {
  const body = req.body;
  if (!body || body.function !== 'GET' && !body || body.function !== 'ADD' && !body || body.function !== 'UPD' && !body || body.function !== 'DLT') {
    return res.status(400).json({ error: 'Oi! Expected "function": ' || body.function || ' found in your JSON' });
  }

  const food = body.food || {};
  const rtntext = body.rtntext || 'status';

  // Fire up the program call
  const program = new ProgramCall('WEBFOOD', { lib: 'NICKLITTEN' });

  // Input params – match your RPGLE defs
  program.addParam({ name: 'ingid', type: '10i0', value: (food.ingid || 0).toString() });
  program.addParam({ name: 'ingname', type: '50A', value: food.ingname || '' });
  program.addParam({ name: 'category', type: '20A', value: food.category || '' });
  program.addParam({ name: 'measure', type: '10A', value: food.measure || '' });
  program.addParam({ name: 'quantity', type: '10i0', value: (food.quantity || 0).toString() });
  program.addParam({ name: 'expdate', type: '10A', value: food.expdate || '' });  // YYYY-MM-DD, yeah?
  program.addParam({ name: 'organic', type: '1A', value: food.organic ? 'Y' : 'N' });

  // Output: the status
  program.addParam({ name: 'status', type: '100A', io: 'out', value: '' });

  // Queue it up and run
  connection.add(program);
  connection.run((error, xmlOutput) => {
    connection.clear();  // Tidy up

    if (error) {
      console.error('Program call went pear-shaped:', error);
      return res.status(500).json({ error: 'RPGLE call failed', details: error.message });
    }

    // Parse the XML response
    const parser = new XMLParser({ ignoreAttributes: false });
    const result = parser.parse(xmlOutput);

    // Nab the status (tweak path if your XML's quirky)
    let status = 'No word back';
    if (result.myscript && result.myscript.pgm && result.myscript.pgm.parm) {
      const parms = Array.isArray(result.myscript.pgm.parm) ? result.myscript.pgm.parm : [result.myscript.pgm.parm];
      const statusParm = parms[parms.length - 1];
      if (statusParm && statusParm.$.name === 'status') {
        status = statusParm.data || 'Empty status';
      }
    }

    // Bundle and send
    const response = { [rtntext]: status };
    res.json(response);
  });
});

// Kick it off
app.listen(port, () => {
  console.log(`Food API endpoint live at http://localhost:${port}/api/food`);
});