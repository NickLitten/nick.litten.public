**FREE

/// Program: MODERNISED - Order Processing with Subprocedures
///
/// Description: Demonstrates proper separation of concerns using subprocedures.
///              Refactored from monolithic PROCESSORD subroutine into three
///              focused subprocedures for better maintainability and testability.
///
/// Purpose: Educational example demonstrating:
///   - Separation of concerns with subprocedures
///   - Single Responsibility Principle (SRP)
///   - Focused, testable functions
///   - Clean code architecture
///   - Proper parameter passing with CONST
///   - Return value patterns
///
/// Features:
///   - CalculateOrderTotal: Computes total from order lines
///   - ValidateCustomerCredit: Checks credit limit approval
///   - CheckItemAvailability: Verifies inventory levels
///   - Each subprocedure has single, clear purpose
///   - Hardcoded demo data for educational clarity
///   - Printer file output for order status
///
/// Subprocedures:
///   - CalculateOrderTotal() -> Packed(9:2)
///     Calculates total amount for all order lines
///   - ValidateCustomerCredit(orderTotal) -> Ind
///     Validates if order is within credit limit
///   - CheckItemAvailability(item, quantity) -> Ind
///     Checks if requested quantity is available
///
/// Usage: CALL MODERNISED
///        Processes hardcoded order and prints results
///
/// Dependencies:
///   - File: QPRINT (printer file)
///
/// Reference:
///   https://www.nicklitten.com/your-rpgle-sub-procedure-is-doing-too-much/
///
/// Modification History:
///   1.0 2024-01-15 | Nick Litten | Initial creation - refactored from monolithic code
///   1.1 2025-02-15 | Nick Litten | Code Commenting
///

Ctl-Opt DftActGrp(*No) ActGrp(*New) Option(*SrcStmt:*NoDebugIO)
  copyright('Modernised Order Processing | 1.1 - Subprocedure Example');

// 
// File declarations
// 
Dcl-F QPRINT Printer(132) Usage(*Output);

// 
// Data structures
// 
Dcl-Ds OrderLine Qualified;
   Item Char(10);
   Qty Packed(3:0);
   Price Packed(6:2);
End-Ds;

// 
// Global variables
// 
Dcl-S OrderTotal Packed(9:2);
Dcl-S CreditApproved Ind;

// 
// Main Program Logic
// 

// Step 1: Calculate the order total
OrderTotal = CalculateOrderTotal();

// Step 2: Validate customer credit limit
CreditApproved = ValidateCustomerCredit(OrderTotal);

// Step 3: Process order if credit approved
If (CreditApproved);
   // Check availability for each item
   If (CheckItemAvailability('WIDGET001': 5));
      If (CheckItemAvailability('GADGET002': 2));
         // All items available, print order total
         Write TOTALREC;
      EndIf;
   EndIf;
Else;
   // Credit limit exceeded
   Write NOCREDIT;
EndIf;

*InLR = *On;
Return;

// 
// Subprocedure: CalculateOrderTotal
// Purpose: Calculate the total amount for all order lines
// Returns: Total order amount as Packed(9:2)
// Notes: In production, this would read from an order file
//        For demo purposes, uses hardcoded order lines
// 
Dcl-Proc CalculateOrderTotal;
   Dcl-Pi *N Packed(9:2) End-Pi;
  
   Dcl-S Total Packed(9:2) Inz(0);
   Dcl-S LineAmount Packed(9:2);
  
   // Process first order line - WIDGET001
   OrderLine.Item = 'WIDGET001';
   OrderLine.Qty = 5;
   OrderLine.Price = 19.95;
   LineAmount = OrderLine.Qty * OrderLine.Price;
   Total += LineAmount;
  
   // Process second order line - GADGET002
   OrderLine.Item = 'GADGET002';
   OrderLine.Qty = 2;
   OrderLine.Price = 49.50;
   LineAmount = OrderLine.Qty * OrderLine.Price;
   Total += LineAmount;
  
   Return Total;
End-Proc;

// 
// Subprocedure: ValidateCustomerCredit
// Purpose: Validate if order total is within customer credit limit
// Parameters: pOrderTotal - The total amount to validate (Const)
// Returns: *On if approved, *Off if credit limit exceeded
// Notes: In production, credit limit would be retrieved from customer master
//        For demo purposes, uses hardcoded credit limit constant
// 
Dcl-Proc ValidateCustomerCredit;
   Dcl-Pi *N Ind;
      pOrderTotal Packed(9:2) Const;
   End-Pi;
  
   Dcl-C CREDIT_LIMIT Const(250.00);
   Dcl-S Approved Ind Inz(*Off);
  
   If (pOrderTotal <= CREDIT_LIMIT);
      Approved = *On;
   EndIf;
  
   Return Approved;
End-Proc;

// 
// Subprocedure: CheckItemAvailability
// Purpose: Check if requested quantity is available in inventory
// Parameters: pItem - Item code to check (Const)
//            pQuantity - Quantity needed (Const)
// Returns: *On if available, *Off if insufficient inventory
// Notes: In production, this would query inventory database
//        For demo purposes, uses hardcoded inventory levels
//        Writes NOITEM record if item not available
// 
Dcl-Proc CheckItemAvailability;
   Dcl-Pi *N Ind;
      pItem Char(10) Const;
      pQuantity Packed(3:0) Const;
   End-Pi;
  
   Dcl-S OnHand Packed(5:0);
   Dcl-S Available Ind Inz(*Off);
  
   // In real application, this would query inventory database
   // For demo, using hardcoded values matching original logic
   Select;
      When (pItem = 'WIDGET001');
         OnHand = 10;
      When (pItem = 'GADGET002');
         OnHand = 1;
      Other;
         OnHand = 0;
   EndSl;
  
   If (pQuantity <= OnHand);
      Available = *On;
   Else;
      // Item not available - write error record
      Write NOITEM;
   EndIf;
  
   Return Available;
End-Proc;

// 
// Output specifications (printer file records)
// 
// Note: These would typically be in a separate DDS or DSPF file
// Shown here for completeness of the example
