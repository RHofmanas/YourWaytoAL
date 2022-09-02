page 50111 "Test Array Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;

    layout
    {
        area(Content)
        {
            group(General)
            {
                group(Input)
                {

                    field("InputNumber[1]"; InputNumber[1])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[2]"; InputNumber[2])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[3]"; InputNumber[3])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[4]"; InputNumber[4])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[5]"; InputNumber[5])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[6]"; InputNumber[6])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[7]"; InputNumber[7])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[8]"; InputNumber[8])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[9]"; InputNumber[9])
                    {
                        ApplicationArea = All;
                    }
                    field("InputNumber[10]"; InputNumber[10])
                    {
                        ApplicationArea = All;
                    }
                }
                group(Output)
                {

                    field("OutputNumber[1]"; OutputNumber[1])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[2]"; OutputNumber[2])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[3]"; OutputNumber[3])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[4]"; OutputNumber[4])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[5]"; OutputNumber[5])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[6]"; OutputNumber[6])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[7]"; OutputNumber[7])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[8]"; OutputNumber[8])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[9]"; OutputNumber[9])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("OutputNumber[10]"; OutputNumber[10])
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                }
                group(Counter)
                {
                    field("Loop Count"; LoopCount)
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                    field("Swap Count"; SwapCount)
                    {
                        ApplicationArea = All;
                        Editable = False;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Clear)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Clear(InputNumber);
                    Clear(OutputNumber);
                    LoopCount := 0;
                    SwapCount := 0;
                end;
            }
            action("Generate Input")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    LoopCount := 0;
                    SwapCount := 0;

                    For idx := 1 to ArrayLen(InputNumber) do
                        InputNumber[idx] := Random(ArrayLen(InputNumber));
                end;
            }
            action("Populate Output")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    LoopCount := 0;
                    SwapCount := 0;

                    idx := 1;
                    While (idx <= ArrayLen(InputNumber)) and (idx <= ArrayLen(OutputNumber)) do begin
                        OutputNumber[idx] := InputNumber[idx];
                        idx += 1;
                    end;
                end;
            }
            action(Sort)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    LoopCount := 0;
                    SwapCount := 0;

                    repeat
                        IsSorted := true;
                        For idx := ArrayLen(OutputNumber) downto 2 do begin
                            LoopCount += 1;
                            If OutputNumber[idx] < OutputNumber[idx - 1] then begin
                                Swap();
                                SwapCount += 1;
                                IsSorted := false;
                            end;
                        end;
                    until IsSorted
                end;
            }
            action(ImprovedSort)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    LoopCount := 0;
                    SwapCount := 0;
                    LowestSwitch := 2;

                    repeat
                        IsSorted := true;
                        For idx := ArrayLen(OutputNumber) downto LowestSwitch do begin
                            LoopCount += 1;
                            If OutputNumber[idx] < OutputNumber[idx - 1] then begin
                                Swap();
                                SwapCount += 1;
                                IsSorted := false;
                                LowestSwitch := idx + 1;
                            end;
                        end;
                    until IsSorted
                end;
            }
        }
    }

    procedure Swap()
    var
        temp: Integer;
    begin
        temp := OutputNumber[idx];
        OutputNumber[idx] := OutputNumber[idx - 1];
        OutputNumber[idx - 1] := temp;
    end;

    var
        InputNumber: array[10] of Integer;
        OutputNumber: array[10] of Integer;
        LoopCount: Integer;
        SwapCount: Integer;
        idx: Integer;
        IsSorted: Boolean;
        LowestSwitch: Integer;
        TempNumber: Integer;
}