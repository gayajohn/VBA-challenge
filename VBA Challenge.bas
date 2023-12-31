Sub vbachallenge():

' to loop through every work sheet -----------------------------------------------------------------------------------------------------------------
For Each ws In Worksheets
    
    
    ' setting labels for the output table
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Yearly Change"
    ws.Cells(1, 11).Value = "Percent Change"
    ws.Cells(1, 12).Value = "Total Stock Volume"
    
    'stores number of rows
    Dim no_of_rows As Long
    no_of_rows = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    
    'variables to store price at open, price at close, and total trading volume
    Dim open_price, close_price, total_volume As Double
    total_volume = 0
    
    'variable to track rows on the output table
    Dim counter As Integer
    counter = 2
    
    'variable to loop through the rows of data
    Dim r As Long
    
    'the starting value of open_price
    open_price = ws.Cells(2, 3).Value
    
    
    'for loop through all the rows ________________________________________________________________________________________________
    For r = 2 To no_of_rows
        
        
        'checks if the adjascent tickers are the same, and adds volume to the total_volume variable
        If ws.Cells(r, 1) = ws.Cells(r + 1, 1) Then
        total_volume = total_volume + ws.Cells(r, 7).Value
    
    
        'checks if the adjascebt tickers are not the same
        ElseIf ws.Cells(r, 1) <> ws.Cells(r + 1, 1) Then
        
        ws.Cells(counter, 9).Value = ws.Cells(r, 1).Value 'display ticker
        ws.Cells(counter, 12).Value = total_volume + ws.Cells(r, 7).Value 'display total volume
        close_price = ws.Cells(r, 6).Value ' assign close price
        ws.Cells(counter, 10).Value = close_price - open_price ' display yearly change
        
        
            'checks if the yearly change is positive or negative and then colours the cell green or red accordingly
            If close_price > open_price Then
            ws.Cells(counter, 10).Interior.ColorIndex = 4
            ElseIf close_price < open_price Then
            ws.Cells(counter, 10).Interior.ColorIndex = 3
            Else
            End If
        
        ws.Cells(counter, 11).Value = (close_price - open_price) / open_price ' display percentage change
        ws.Cells(counter, 11).NumberFormat = "0.00%"
        open_price = ws.Cells(r + 1, 3) ' reset open_price for next ticker
        total_volume = 0 'reset total volume to 0
        counter = counter + 1 'move to the next row in the output section
        
        End If
        
    Next r
    ' for loop through all rows of data_________________________________________________________________________________________________________________
    
    
    
    Dim tick_inc, tick_dec, tick_vol As String ' store ticker with greatest % increase, greatest % decrease, and greatest total volume
    Dim val_inc, val_dec As Double 'store percentage values for stocks with greatest % increase and decrease
    Dim val_vol As Variant 'store total volume of stock with highest volume
    
    val_vol = 0
    val_inc = 0
    val_dec = 0
    
    
    ' to loop through output table, the counter variable contains number of rows in the output table____________________________________________________
    Dim o As Integer
    For o = 2 To counter
            
            
        'to find row with highest volume
        If val_vol < ws.Cells(o, 12).Value Then
        val_vol = ws.Cells(o, 12).Value
        tick_vol = ws.Cells(o, 9).Value
        End If
        
        'to find row with highest % increase
        If val_inc < ws.Cells(o, 11).Value Then
        val_inc = ws.Cells(o, 11).Value
        tick_inc = ws.Cells(o, 9).Value
        End If
        
        'to find row with highest % decrease
        If val_dec > ws.Cells(o, 11).Value Then
        val_dec = ws.Cells(o, 11).Value
        tick_dec = ws.Cells(o, 9).Value
        End If
        
    Next o
    ' to loop through output table______________________________________________________________________________________________________________________
    
    
    
    'creating the new output table
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Greatest Total Volume"
    ws.Cells(2, 16).Value = tick_inc
    ws.Cells(2, 17).Value = val_inc
    ws.Cells(2, 17).NumberFormat = "0.00%"
    ws.Cells(3, 16).Value = tick_dec
    ws.Cells(3, 17).Value = val_dec
    ws.Cells(3, 17).NumberFormat = "0.00%"
    ws.Cells(4, 16).Value = tick_vol
    ws.Cells(4, 17).Value = val_vol
    
    ws.Range("I1:Q1").EntireColumn.AutoFit
    
    
Next ws
'to loop through every worksheet --------------------------------------------------------------------------------------------------------------


End Sub

