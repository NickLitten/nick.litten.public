/**
 * Calculate Version Number from Modification History
 * 
 * This script analyzes a source file's modification history section
 * and calculates the version number based on the number of entries.
 * 
 * Usage: node calculate-version.js <filepath>
 */

const fs = require('fs');
const path = require('path');

/**
 * Extract modification history from file content
 * @param {string} content - File content
 * @param {string} fileType - File extension (rpgle, clle, etc.)
 * @returns {number} - Number of modification entries
 */
function countModifications(content, fileType) {
    let modificationCount = 0;
    
    // Different comment patterns for different file types
    const patterns = {
        rpgle: /^\/\/\/\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm,
        sqlrpgle: /^\/\/\/\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm,
        clle: /^\/\/\/\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm,
        dspf: /^\s+A\*\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm,
        pf: /^\s+A\*\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm,
        table: /^--\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm,
        sql: /^--\s+V\.\d{3}\s+\d{4}-\d{2}-\d{2}/gm
    };
    
    const pattern = patterns[fileType] || patterns.rpgle;
    const matches = content.match(pattern);
    
    if (matches) {
        modificationCount = matches.length;
    }
    
    return modificationCount;
}

/**
 * Format version number with zero padding
 * @param {number} version - Version number
 * @returns {string} - Formatted version (e.g., "V.042")
 */
function formatVersion(version) {
    return `V.${version.toString().padStart(3, '0')}`;
}

/**
 * Get file type from extension
 * @param {string} filepath - File path
 * @returns {string} - File type
 */
function getFileType(filepath) {
    const ext = path.extname(filepath).toLowerCase();
    
    // Handle compound extensions like .pgm.rpgle
    const basename = path.basename(filepath);
    if (basename.includes('.pgm.rpgle') || basename.includes('.mod.rpgle')) {
        return 'rpgle';
    }
    if (basename.includes('.pgm.sqlrpgle') || basename.includes('.mod.sqlrpgle')) {
        return 'sqlrpgle';
    }
    if (basename.includes('.pgm.clle')) {
        return 'clle';
    }
    
    // Simple extension mapping
    const typeMap = {
        '.rpgle': 'rpgle',
        '.sqlrpgle': 'sqlrpgle',
        '.clle': 'clle',
        '.dspf': 'dspf',
        '.pf': 'pf',
        '.table': 'table',
        '.sql': 'sql'
    };
    
    return typeMap[ext] || 'rpgle';
}

/**
 * Main function
 */
function main() {
    const args = process.argv.slice(2);
    
    if (args.length === 0) {
        console.error('Usage: node calculate-version.js <filepath>');
        process.exit(1);
    }
    
    const filepath = args[0];
    
    if (!fs.existsSync(filepath)) {
        console.error(`Error: File not found: ${filepath}`);
        process.exit(1);
    }
    
    try {
        const content = fs.readFileSync(filepath, 'utf8');
        const fileType = getFileType(filepath);
        const modCount = countModifications(content, fileType);
        const version = formatVersion(modCount);
        
        console.log(JSON.stringify({
            filepath: filepath,
            fileType: fileType,
            modificationCount: modCount,
            version: version
        }, null, 2));
        
    } catch (error) {
        console.error(`Error processing file: ${error.message}`);
        process.exit(1);
    }
}

// Run if called directly
if (require.main === module) {
    main();
}

module.exports = {
    countModifications,
    formatVersion,
    getFileType
};

// Made with Bob
