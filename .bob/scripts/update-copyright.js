/**
 * Update Copyright Statement in Source Files
 * 
 * This script updates the copyright statement in IBM i source files
 * with the calculated version number and program description.
 * 
 * Usage: node update-copyright.js <filepath> <version> <description>
 */

const fs = require('fs');
const path = require('path');

/**
 * Get program name from filepath
 * @param {string} filepath - File path
 * @returns {string} - Program name
 */
function getProgramName(filepath) {
    const basename = path.basename(filepath);
    // Extract program name before first dash or dot
    const match = basename.match(/^([A-Z0-9]+)/);
    return match ? match[1] : basename.split('.')[0].toUpperCase();
}

/**
 * Update copyright in RPGLE/SQLRPGLE file
 * @param {string} content - File content
 * @param {string} programName - Program name
 * @param {string} version - Version string (e.g., "V.042")
 * @param {string} description - Program description
 * @returns {string} - Updated content
 */
function updateRPGLECopyright(content, programName, version, description) {
    const copyrightPattern = /ctl-opt\s+copyright\([^)]+\)\s*;/i;
    const newCopyright = `ctl-opt\n  copyright('${programName} | ${version} | ${description}')\n  ;`;
    
    if (copyrightPattern.test(content)) {
        return content.replace(copyrightPattern, newCopyright);
    } else {
        // Insert after /include statements or at beginning of ctl-opt section
        const ctlOptPattern = /(\/include[^\n]+\n+)(ctl-opt)/i;
        if (ctlOptPattern.test(content)) {
            return content.replace(ctlOptPattern, `$1${newCopyright}\n\n$2`);
        }
    }
    
    return content;
}

/**
 * Update copyright in CLLE file
 * @param {string} content - File content
 * @param {string} programName - Program name
 * @param {string} version - Version string (e.g., "V.042")
 * @param {string} description - Program description
 * @returns {string} - Updated content
 */
function updateCLLECopyright(content, programName, version, description) {
    // Remove "V." prefix for CLLE version format
    const versionNum = version.replace('V.', '');
    const copyrightPattern = /COPYRIGHT\s+TEXT\([^)]+\)/i;
    const newCopyright = `COPYRIGHT  TEXT('${programName} Ver:${versionNum} ${description}')`;
    
    if (copyrightPattern.test(content)) {
        return content.replace(copyrightPattern, newCopyright);
    }
    
    return content;
}

/**
 * Extract description from file header
 * @param {string} content - File content
 * @param {string} fileType - File type
 * @returns {string} - Description
 */
function extractDescription(content, fileType) {
    let descPattern;
    
    if (fileType === 'clle') {
        descPattern = /\/\/\/\s+Description:\s+([^\n]+)/i;
    } else {
        descPattern = /\/\/\/\s+Description:\s+([^\n]+)/i;
    }
    
    const match = content.match(descPattern);
    if (match) {
        return match[1].trim();
    }
    
    return 'IBM i Program';
}

/**
 * Get file type from extension
 * @param {string} filepath - File path
 * @returns {string} - File type
 */
function getFileType(filepath) {
    const basename = path.basename(filepath).toLowerCase();
    
    if (basename.includes('.clle')) return 'clle';
    if (basename.includes('.sqlrpgle')) return 'sqlrpgle';
    if (basename.includes('.rpgle')) return 'rpgle';
    
    const ext = path.extname(filepath).toLowerCase();
    const typeMap = {
        '.rpgle': 'rpgle',
        '.sqlrpgle': 'sqlrpgle',
        '.clle': 'clle'
    };
    
    return typeMap[ext] || 'rpgle';
}

/**
 * Update copyright in file
 * @param {string} filepath - File path
 * @param {string} version - Version string
 * @param {string} description - Optional description (extracted if not provided)
 * @returns {object} - Result object
 */
function updateCopyright(filepath, version, description = null) {
    if (!fs.existsSync(filepath)) {
        return {
            success: false,
            error: `File not found: ${filepath}`
        };
    }
    
    try {
        const content = fs.readFileSync(filepath, 'utf8');
        const fileType = getFileType(filepath);
        const programName = getProgramName(filepath);
        
        // Extract description if not provided
        if (!description) {
            description = extractDescription(content, fileType);
        }
        
        let updatedContent;
        
        if (fileType === 'clle') {
            updatedContent = updateCLLECopyright(content, programName, version, description);
        } else {
            updatedContent = updateRPGLECopyright(content, programName, version, description);
        }
        
        // Write back to file
        fs.writeFileSync(filepath, updatedContent, 'utf8');
        
        return {
            success: true,
            filepath: filepath,
            programName: programName,
            version: version,
            description: description,
            fileType: fileType
        };
        
    } catch (error) {
        return {
            success: false,
            error: error.message
        };
    }
}

/**
 * Main function
 */
function main() {
    const args = process.argv.slice(2);
    
    if (args.length < 2) {
        console.error('Usage: node update-copyright.js <filepath> <version> [description]');
        console.error('Example: node update-copyright.js myprogram.rpgle V.042 "My Program Description"');
        process.exit(1);
    }
    
    const filepath = args[0];
    const version = args[1];
    const description = args[2] || null;
    
    const result = updateCopyright(filepath, version, description);
    
    console.log(JSON.stringify(result, null, 2));
    
    if (!result.success) {
        process.exit(1);
    }
}

// Run if called directly
if (require.main === module) {
    main();
}

module.exports = {
    updateCopyright,
    getProgramName,
    extractDescription
};

// Made with Bob
