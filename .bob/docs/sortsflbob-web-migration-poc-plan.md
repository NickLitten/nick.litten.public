# SORTSFLBOB Web Migration POC Plan
## Hybrid Approach: CGI POC → API Gateway Production

---

## Executive Summary

This plan outlines a phased migration of [`SORTSFLBOB`](IBMi/SubfileSamples/Column_Sorting_Subfile/SORTSFLBOB-Sortable_Subfile_IBM_BOB.sqlrpgle) from 5250 green-screen to modern web UI using a hybrid approach:

- **Phase 1 (POC)**: IBM i CGI with simple HTML/JavaScript (2 weeks)
- **Phase 2 (Production)**: REST API Gateway with enhanced frontend (6-8 weeks)
- **Phase 3 (Enhancement)**: Progressive improvements and scaling (ongoing)

This approach minimizes risk, validates concepts quickly, and provides clear evolution path to production-grade solution.

---

## Current 5250 Architecture Analysis

### Program Components

**[`SORTSFLBOB`](IBMi/SubfileSamples/Column_Sorting_Subfile/SORTSFLBOB-Sortable_Subfile_IBM_BOB.sqlrpgle:1-358)** - Main SQLRPGLE Program
- Interactive subfile with column sorting
- Dynamic SQL cursor management
- Search filtering across multiple fields
- Error handling and logging

**[`SORTSFL`](IBMi/SubfileSamples/Column_Sorting_Subfile/SORTSFL-Sortable_Subfile.dspf:1-64)** - Display File (DSPF)
- 24x80 character display
- Subfile with 9999 record capacity
- Column headers with mouse click detection
- Search input fields
- Function key support (F3=Exit, F9=Sort)

**[`SORTSFLPF`](IBMi/SubfileSamples/Column_Sorting_Subfile/SORTSFLPF-Sort_Subfile_Sample_table.pf:1-11)** - Physical File
- 5 fields: SORTDATE, SORTTIME, SORTUSER, SORTTEXT, SORTSTATUS
- Composite key on all fields

### Key Features to Migrate

1. **Column Sorting**
   - Click column header to sort
   - Toggle ascending/descending
   - Visual feedback on sort column

2. **Search Filtering**
   - Filter by any field
   - Partial match (LIKE) searches
   - Case-insensitive matching
   - Multiple criteria combination

3. **Data Display**
   - Paginated results (13 rows per page)
   - Scrollbar for large datasets
   - "No data" message handling
   - Record count display

4. **User Interaction**
   - Keyboard navigation
   - Mouse support
   - Function keys (F3, F9)
   - Cursor positioning

---

## Phase 1: POC Implementation (2 Weeks)

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        Web Browser                          │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  HTML Page (sortsfl.html)                             │  │
│  │  - Table with sortable columns                        │  │
│  │  - Search input fields                                │  │
│  │  - JavaScript for interactivity                       │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ HTTP GET/POST
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    IBM i HTTP Server                        │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Apache CGI Configuration                             │  │
│  │  /cgi-bin/sortsfl → SORTSFLCGI                        │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ Program Call
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    IBM i ILE Programs                       │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  SORTSFLCGI (New SQLRPGLE CGI Program)                │  │
│  │  - Parse CGI environment variables                    │  │
│  │  - Execute SQL queries                                │  │
│  │  - Generate JSON response                             │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ SQL
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    IBM i Database                           │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  SORTSFLPF (Existing Physical File)                   │  │
│  │  - No changes required                                │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Components to Build

#### 1. SORTSFLCGI - CGI Program (SQLRPGLE)

**File**: `SORTSFLCGI-Sortable_Subfile_CGI.sqlrpgle`

**Purpose**: Handle HTTP requests and return JSON data

**Key Functions**:
```rpgle
// Parse CGI environment variables
dcl-proc ParseCgiRequest;
  // Read QUERY_STRING for GET parameters
  // Read stdin for POST data
  // Extract: sortField, sortOrder, search criteria
end-proc;

// Build SQL query dynamically
dcl-proc BuildSqlQuery;
  // Construct WHERE clause from search filters
  // Add ORDER BY clause from sort parameters
  // Return SQL statement string
end-proc;

// Execute query and format JSON
dcl-proc ExecuteAndFormatJson;
  // Open cursor with dynamic SQL
  // Fetch records
  // Build JSON array
  // Return JSON string
end-proc;

// Send HTTP response
dcl-proc SendHttpResponse;
  // Write HTTP headers (Content-Type: application/json)
  // Write JSON body
  // Handle errors with proper HTTP status codes
end-proc;
```

**Sample JSON Response**:
```json
{
  "success": true,
  "recordCount": 42,
  "data": [
    {
      "sortDate": "2026-06-11",
      "sortTime": "09:30:00",
      "sortUser": "NICKLITTEN",
      "sortText": "Sample audit entry for testing",
      "sortStatus": "A"
    }
  ],
  "sortField": "SORTDATE",
  "sortOrder": "ASC"
}
```

#### 2. HTML Frontend

**File**: `sortsfl.html`

**Structure**:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sortable Subfile - Web Version</title>
    <link rel="stylesheet" href="sortsfl.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>SORTSFL - Column Sortable Subfile</h1>
            <p class="instructions">
                Click column headers to sort. Enter search criteria to filter.
            </p>
        </header>

        <div class="search-panel">
            <input type="text" id="searchDate" placeholder="Date">
            <input type="text" id="searchTime" placeholder="Time">
            <input type="text" id="searchUser" placeholder="User ID">
            <input type="text" id="searchText" placeholder="Text">
            <input type="text" id="searchStatus" placeholder="Status">
            <button id="btnSearch">Search</button>
            <button id="btnClear">Clear</button>
        </div>

        <div class="table-container">
            <table id="dataTable">
                <thead>
                    <tr>
                        <th data-field="SORTDATE" class="sortable">
                            Date <span class="sort-indicator"></span>
                        </th>
                        <th data-field="SORTTIME" class="sortable">
                            Time <span class="sort-indicator"></span>
                        </th>
                        <th data-field="SORTUSER" class="sortable">
                            User ID <span class="sort-indicator"></span>
                        </th>
                        <th data-field="SORTTEXT" class="sortable">
                            Text <span class="sort-indicator"></span>
                        </th>
                        <th data-field="SORTSTATUS" class="sortable">
                            Status <span class="sort-indicator"></span>
                        </th>
                    </tr>
                </thead>
                <tbody id="dataBody">
                    <!-- Data rows populated by JavaScript -->
                </tbody>
            </table>
        </div>

        <div class="status-bar">
            <span id="recordCount">0 records</span>
            <span id="errorMessage" class="error"></span>
        </div>

        <div class="button-bar">
            <button id="btnExit">Exit (F3)</button>
        </div>
    </div>

    <script src="sortsfl.js"></script>
</body>
</html>
```

#### 3. CSS Styling

**File**: `sortsfl.css`

**Key Styles**:
```css
/* 5250-inspired color scheme */
:root {
    --bg-color: #000000;
    --text-color: #00ff00;
    --header-color: #00ffff;
    --highlight-color: #ffff00;
    --error-color: #ff0000;
}

/* Modern responsive layout */
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'Courier New', monospace;
}

/* Sortable column headers */
th.sortable {
    cursor: pointer;
    user-select: none;
    position: relative;
    padding-right: 20px;
}

th.sortable:hover {
    background-color: #333;
}

/* Sort indicators */
.sort-indicator::after {
    content: '⇅';
    position: absolute;
    right: 5px;
    opacity: 0.3;
}

th.sort-asc .sort-indicator::after {
    content: '↑';
    opacity: 1;
}

th.sort-desc .sort-indicator::after {
    content: '↓';
    opacity: 1;
}

/* Responsive table */
.table-container {
    overflow-x: auto;
    max-height: 600px;
    overflow-y: auto;
}

/* Search panel */
.search-panel {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 10px;
    margin-bottom: 20px;
}
```

#### 4. JavaScript Logic

**File**: `sortsfl.js`

**Key Functions**:
```javascript
// State management
const state = {
    sortField: 'SORTDATE',
    sortOrder: 'ASC',
    searchCriteria: {},
    data: []
};

// Fetch data from CGI program
async function fetchData() {
    const params = new URLSearchParams({
        sortField: state.sortField,
        sortOrder: state.sortOrder,
        ...state.searchCriteria
    });
    
    try {
        const response = await fetch(`/cgi-bin/sortsfl?${params}`);
        const json = await response.json();
        
        if (json.success) {
            state.data = json.data;
            renderTable();
            updateRecordCount(json.recordCount);
        } else {
            showError(json.message);
        }
    } catch (error) {
        showError('Failed to fetch data: ' + error.message);
    }
}

// Render table rows
function renderTable() {
    const tbody = document.getElementById('dataBody');
    tbody.innerHTML = '';
    
    state.data.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${row.sortDate}</td>
            <td>${row.sortTime}</td>
            <td>${row.sortUser}</td>
            <td>${row.sortText}</td>
            <td>${row.sortStatus}</td>
        `;
        tbody.appendChild(tr);
    });
    
    updateSortIndicators();
}

// Handle column header clicks
function handleColumnClick(event) {
    const th = event.target.closest('th');
    if (!th || !th.dataset.field) return;
    
    const field = th.dataset.field;
    
    if (state.sortField === field) {
        // Toggle sort order
        state.sortOrder = state.sortOrder === 'ASC' ? 'DESC' : 'ASC';
    } else {
        // New field, default to ascending
        state.sortField = field;
        state.sortOrder = 'ASC';
    }
    
    fetchData();
}

// Handle search
function handleSearch() {
    state.searchCriteria = {
        searchDate: document.getElementById('searchDate').value,
        searchTime: document.getElementById('searchTime').value,
        searchUser: document.getElementById('searchUser').value,
        searchText: document.getElementById('searchText').value,
        searchStatus: document.getElementById('searchStatus').value
    };
    
    fetchData();
}

// Initialize event listeners
document.addEventListener('DOMContentLoaded', () => {
    // Column header clicks
    document.querySelectorAll('th.sortable').forEach(th => {
        th.addEventListener('click', handleColumnClick);
    });
    
    // Search button
    document.getElementById('btnSearch').addEventListener('click', handleSearch);
    
    // Clear button
    document.getElementById('btnClear').addEventListener('click', () => {
        document.querySelectorAll('.search-panel input').forEach(input => {
            input.value = '';
        });
        state.searchCriteria = {};
        fetchData();
    });
    
    // Exit button
    document.getElementById('btnExit').addEventListener('click', () => {
        window.close();
    });
    
    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => {
        if (e.key === 'F3' || (e.key === 'Escape')) {
            e.preventDefault();
            window.close();
        }
    });
    
    // Initial data load
    fetchData();
});
```

### Apache Configuration

**File**: `/www/apachedft/conf/httpd.conf` (or virtual host config)

```apache
# Enable CGI execution
ScriptAlias /cgi-bin/ /QSYS.LIB/YOURLIB.LIB/

# Set CGI program permissions
<Directory "/QSYS.LIB/YOURLIB.LIB/">
    Options +ExecCGI
    SetHandler cgi-script
    Require all granted
</Directory>

# Serve static files
Alias /sortsfl/ /www/sortsfl/htdocs/

<Directory "/www/sortsfl/htdocs/">
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
```

### POC Deliverables

1. **SORTSFLCGI.sqlrpgle** - CGI program source
2. **sortsfl.html** - Main HTML page
3. **sortsfl.css** - Stylesheet
4. **sortsfl.js** - JavaScript logic
5. **Apache configuration** - HTTP server setup
6. **Test data script** - Populate SORTSFLPF with sample data
7. **Documentation** - Setup and usage instructions

### POC Success Criteria

- [ ] Display data from SORTSFLPF in web browser
- [ ] Column sorting works (click headers)
- [ ] Search filtering works (all fields)
- [ ] Responsive design (works on desktop and tablet)
- [ ] Error handling displays user-friendly messages
- [ ] Performance: < 2 seconds for 1000 records
- [ ] No changes required to existing SORTSFLPF table

---

## Phase 2: Production Implementation (6-8 Weeks)

### Enhanced Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Web Browser                          │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Enhanced Frontend (React/Vue or Vanilla JS)          │  │
│  │  - Component-based architecture                       │  │
│  │  - State management                                   │  │
│  │  - Advanced UI features                               │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ REST API (HTTPS)
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    API Gateway Server                       │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Node.js/Python/Java REST API                         │  │
│  │  - Authentication (JWT/OAuth)                         │  │
│  │  - Rate limiting                                      │  │
│  │  - Request validation                                 │  │
│  │  - Response caching                                   │  │
│  │  - Logging and monitoring                             │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ ODBC/JDBC
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    IBM i Database                           │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  SORTSFLPF + Views/Stored Procedures                  │  │
│  │  - Optimized indexes                                  │  │
│  │  - Business logic in SQL                              │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### API Specification

#### Endpoints

**1. GET /api/v1/sortsfl/data**

Query Parameters:
- `sortField` (string): Column to sort by
- `sortOrder` (string): ASC or DESC
- `searchDate` (string): Filter by date
- `searchTime` (string): Filter by time
- `searchUser` (string): Filter by user
- `searchText` (string): Filter by text
- `searchStatus` (string): Filter by status
- `page` (integer): Page number (default: 1)
- `pageSize` (integer): Records per page (default: 50)

Response:
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "page": 1,
    "pageSize": 50,
    "totalRecords": 1234,
    "totalPages": 25
  },
  "sort": {
    "field": "SORTDATE",
    "order": "ASC"
  }
}
```

**2. GET /api/v1/sortsfl/columns**

Response:
```json
{
  "columns": [
    {
      "name": "SORTDATE",
      "label": "Date",
      "type": "date",
      "sortable": true,
      "searchable": true
    }
  ]
}
```

**3. POST /api/v1/sortsfl/export**

Request Body:
```json
{
  "format": "csv",
  "filters": {...}
}
```

Response: File download

#### Authentication

- JWT tokens for API access
- OAuth 2.0 for enterprise SSO
- API keys for service accounts

#### Error Handling

Standard HTTP status codes:
- 200: Success
- 400: Bad request (validation errors)
- 401: Unauthorized
- 403: Forbidden
- 500: Internal server error

Error response format:
```json
{
  "success": false,
  "error": {
    "code": "INVALID_SORT_FIELD",
    "message": "Invalid sort field: INVALIDFIELD",
    "details": {...}
  }
}
```

### Enhanced Frontend Features

1. **Advanced Sorting**
   - Multi-column sorting
   - Custom sort functions
   - Sort persistence (localStorage)

2. **Enhanced Search**
   - Debounced search (auto-search as you type)
   - Advanced filters (date ranges, wildcards)
   - Saved search criteria

3. **Data Export**
   - Export to CSV, Excel, PDF
   - Print-friendly view
   - Email results

4. **User Preferences**
   - Column visibility toggle
   - Column reordering
   - Page size selection
   - Theme selection (light/dark)

5. **Performance**
   - Virtual scrolling for large datasets
   - Lazy loading
   - Client-side caching
   - Optimistic UI updates

6. **Accessibility**
   - WCAG 2.1 AA compliance
   - Keyboard navigation
   - Screen reader support
   - High contrast mode

### Database Optimizations

**Create Indexes**:
```sql
-- Individual column indexes for sorting
CREATE INDEX SORTSFLPF_DATE ON SORTSFLPF(SORTDATE);
CREATE INDEX SORTSFLPF_TIME ON SORTSFLPF(SORTTIME);
CREATE INDEX SORTSFLPF_USER ON SORTSFLPF(SORTUSER);

-- Composite index for common queries
CREATE INDEX SORTSFLPF_COMP ON SORTSFLPF(SORTDATE, SORTUSER);
```

**Create View for API**:
```sql
CREATE VIEW SORTSFLV AS
SELECT 
    SORTDATE,
    SORTTIME,
    SORTUSER,
    SORTTEXT,
    SORTSTATUS,
    CASE SORTSTATUS 
        WHEN 'A' THEN 'Active'
        WHEN 'I' THEN 'Inactive'
        ELSE 'Unknown'
    END AS STATUS_DESC
FROM SORTSFLPF;
```

**Create Stored Procedure**:
```sql
CREATE PROCEDURE GET_SORTSFL_DATA(
    IN P_SORT_FIELD VARCHAR(20),
    IN P_SORT_ORDER VARCHAR(4),
    IN P_SEARCH_DATE VARCHAR(10),
    IN P_SEARCH_USER VARCHAR(10),
    IN P_PAGE INT,
    IN P_PAGE_SIZE INT
)
LANGUAGE SQL
BEGIN
    -- Dynamic SQL with proper parameter binding
    -- Returns result set with pagination
END;
```

### Security Enhancements

1. **Authentication**
   - JWT token-based authentication
   - Token refresh mechanism
   - Session timeout handling

2. **Authorization**
   - Role-based access control (RBAC)
   - Field-level permissions
   - Audit logging

3. **Data Protection**
   - HTTPS only (TLS 1.3)
   - SQL injection prevention
   - XSS protection
   - CSRF tokens

4. **Rate Limiting**
   - Per-user request limits
   - IP-based throttling
   - DDoS protection

### Monitoring and Logging

1. **Application Logging**
   - Request/response logging
   - Error tracking (Sentry/Rollbar)
   - Performance metrics

2. **Database Monitoring**
   - Query performance tracking
   - Connection pool monitoring
   - Slow query alerts

3. **User Analytics**
   - Usage patterns
   - Feature adoption
   - Error rates

### Production Deliverables

1. **API Gateway**
   - REST API implementation
   - Authentication/authorization
   - API documentation (Swagger/OpenAPI)

2. **Enhanced Frontend**
   - Production-ready UI
   - Responsive design
   - Accessibility compliance

3. **Database Layer**
   - Optimized indexes
   - Views and stored procedures
   - Migration scripts

4. **Infrastructure**
   - Deployment scripts
   - Configuration management
   - Monitoring setup

5. **Documentation**
   - API documentation
   - User guide
   - Administrator guide
   - Developer guide

6. **Testing**
   - Unit tests
   - Integration tests
   - Performance tests
   - Security tests

---

## Phase 3: Enhancement Roadmap (Ongoing)

### Short-term (3-6 months)

1. **Mobile App**
   - Native iOS/Android apps
   - Offline capability
   - Push notifications

2. **Advanced Features**
   - Bulk operations
   - Data import/export
   - Scheduled reports

3. **Integration**
   - SSO with corporate directory
   - Integration with other systems
   - Webhook support

### Long-term (6-12 months)

1. **AI/ML Features**
   - Predictive search
   - Anomaly detection
   - Smart recommendations

2. **Collaboration**
   - Real-time updates (WebSocket)
   - User comments/annotations
   - Shared views

3. **Analytics**
   - Custom dashboards
   - Data visualization
   - Business intelligence integration

---

## Implementation Timeline

### Week 1-2: POC Phase
- **Week 1**: CGI program development and testing
- **Week 2**: Frontend development and integration

### Week 3-4: POC Validation
- **Week 3**: User acceptance testing
- **Week 4**: Performance testing and refinement

### Week 5-8: Production Planning
- **Week 5**: API Gateway architecture design
- **Week 6**: Security and authentication design
- **Week 7**: Database optimization planning
- **Week 8**: Frontend enhancement design

### Week 9-12: Production Development
- **Week 9-10**: API Gateway implementation
- **Week 11**: Enhanced frontend development
- **Week 12**: Integration and testing

### Week 13-14: Production Deployment
- **Week 13**: Staging environment deployment
- **Week 14**: Production deployment and monitoring

---

## Risk Management

### Technical Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| CGI performance issues | High | Implement caching, optimize SQL queries |
| Browser compatibility | Medium | Use standard web APIs, test on major browsers |
| IBM i HTTP server configuration | Medium | Document setup, provide configuration templates |
| Data security concerns | High | Implement HTTPS, authentication, audit logging |

### Business Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| User resistance to change | High | Provide training, maintain 5250 option initially |
| Budget overruns | Medium | Phased approach allows budget control |
| Timeline delays | Medium | POC validates approach before major investment |
| Skill gaps | Medium | Training plan, external consultants if needed |

---

## Success Metrics

### POC Metrics
- [ ] Functional parity with 5250 version
- [ ] Response time < 2 seconds
- [ ] Zero data corruption
- [ ] Positive user feedback (>80% satisfaction)

### Production Metrics
- [ ] 99.9% uptime
- [ ] Response time < 1 second (95th percentile)
- [ ] Support for 100+ concurrent users
- [ ] Zero security incidents
- [ ] 50% reduction in training time vs 5250

---

## Cost Estimate

### POC Phase (2 weeks)
- Developer time: 80 hours @ $100/hr = $8,000
- IBM i HTTP server setup: Included
- Testing: 20 hours @ $100/hr = $2,000
- **Total POC**: $10,000

### Production Phase (6-8 weeks)
- API Gateway development: 200 hours @ $100/hr = $20,000
- Frontend development: 160 hours @ $100/hr = $16,000
- Database optimization: 40 hours @ $100/hr = $4,000
- Security implementation: 80 hours @ $100/hr = $8,000
- Testing and QA: 80 hours @ $100/hr = $8,000
- Documentation: 40 hours @ $100/hr = $4,000
- Infrastructure (API server): $500/month
- **Total Production**: $60,000 + infrastructure

### Ongoing Costs
- Maintenance: $2,000/month
- Infrastructure: $500/month
- Support: $1,000/month
- **Total Ongoing**: $3,500/month

---

## Next Steps

1. **Review and Approve Plan**
   - Stakeholder review
   - Budget approval
   - Timeline confirmation

2. **POC Kickoff**
   - Set up development environment
   - Create project repository
   - Assign development team

3. **POC Development**
   - Week 1: Backend (CGI program)
   - Week 2: Frontend (HTML/CSS/JS)

4. **POC Demo**
   - Present to stakeholders
   - Gather feedback
   - Decide on production phase

5. **Production Planning**
   - Detailed requirements
   - Architecture review
   - Resource allocation

---

## Appendix

### A. Technology Stack Details

**POC Stack**:
- Backend: SQLRPGLE (IBM i)
- Web Server: Apache HTTP Server (IBM i)
- Frontend: HTML5, CSS3, Vanilla JavaScript
- Data Format: JSON

**Production Stack**:
- Backend: Node.js/Express or Python/Flask or Java/Spring Boot
- Database Driver: ODBC/JDBC
- Frontend: React/Vue/Angular or enhanced Vanilla JS
- Authentication: JWT, OAuth 2.0
- API Documentation: Swagger/OpenAPI
- Monitoring: Prometheus, Grafana
- Logging: ELK Stack or Splunk

### B. Reference Links

- IBM i HTTP Server documentation
- SQLRPGLE CGI programming guide
- REST API best practices
- Web accessibility guidelines (WCAG 2.1)

### C. Sample Code Repository Structure

```
sortsfl-web/
├── poc/
│   ├── backend/
│   │   └── SORTSFLCGI.sqlrpgle
│   ├── frontend/
│   │   ├── sortsfl.html
│   │   ├── sortsfl.css
│   │   └── sortsfl.js
│   └── docs/
│       └── setup-guide.md
├── production/
│   ├── api/
│   │   ├── src/
│   │   ├── tests/
│   │   └── docs/
│   ├── frontend/
│   │   ├── src/
│   │   ├── public/
│   │   └── tests/
│   └── database/
│       ├── indexes.sql
│       ├── views.sql
│       └── procedures.sql
└── README.md