page 50105 "Custom Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;

                }
            }
            group(Pricing)
            {

                field("Unit Cost"; rec."Unit Cost")
                {
                    caption = 'Unit Cost';
                    ApplicationArea = all;
                }

                field("Costing Method"; rec."Costing Method")
                {
                    caption = 'Costing Method';
                    ApplicationArea = all;
                }
                field("Profit %"; rec."Profit %")
                {
                    caption = 'Profit';
                    ApplicationArea = all;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                }
            }
            Group(FixedGroup)
            {
                fixed(Ordering)
                {
                    group(SalesOrder)
                    {
                        field("Qty. on Sales Order"; rec."Qty. on Sales Order")
                        {
                            caption = 'Ordering';
                            ApplicationArea = all;
                        }
                        field("Qty. on Sales Return"; rec."Qty. on Sales Return")
                        {
                            caption = 'Returning';
                            ApplicationArea = all;
                        }
                    }
                    group(PurchaseOrder)
                    {
                        field("Qty. on Purch. Order"; rec."Qty. on Purch. Order")
                        {
                            ApplicationArea = all;
                        }
                        field("Qty. on Purch. Return"; rec."Qty. on Purch. Return")
                        {
                            ApplicationArea = all;
                        }
                    }
                    group(ProductionOrder)
                    {
                        field("Qty. on Prod. Order"; rec."Qty. on Prod. Order")
                        {
                            ApplicationArea = all;
                        }
                    }
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(ItemList)
            {
                ApplicationArea = All;
                RunObject = report "Inventory - List";

                trigger OnAction()
                begin

                end;
            }
        }
        area(Processing)
        {

            Action("Run Codeunit A")
            {
                ApplicationArea = all;
                RunObject = codeunit Codeunit_A;
            }

            Action("Run Codeunit B")
            {
                ApplicationArea = all;
                RunObject = codeunit Codeunit_B;
            }

            Action("Run Codeunit C")
            {
                ApplicationArea = all;
                RunObject = codeunit Codeunit_C;
            }

            action(CallPageRunmodal)
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    RunpageonModalMode()
                end;
            }
            action(CallPageRun)
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Runpage()
                end;
            }
            action(CallCodeUnitModal)
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    RunTestCodeunitModal()
                end;
            }
            action(CallCodeUnit)
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    RunTestCodeunit()
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        AddDictionaryValue('OnQueryClosePage');
    end;

    trigger OnAfterGetCurrRecord()
    begin
        AddDictionaryValue('OnAfterGetCurrRecord')
    end;

    trigger OnAfterGetRecord()
    begin
        AddDictionaryValue('OnAfterGetRecord');
    end;

    trigger OnOpenPage()
    begin
        AddDictionaryValue('OnOpenPage');
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        AddDictionaryValue('OnFindRecord');
        // if confirm(which, true) then;
        EXIT(rec.FIND(Which));
    end;

    trigger OnInit()
    begin
        AddDictionaryValue('OnInit');
    end;

    /*
    trigger OnClosePage()
    var
        n: Integer;
    begin
        AddDictionaryValue('OnClosePage');
        for n := 1 to TriggerDictionary.Count() do
            if Confirm(strsubstno('%1 %2', n, TriggerDictionary.Get(n * 10), true)) then;
    end;
    */

    procedure AddDictionaryValue(Which: Text)
    begin
        TriggerPosition += 10;
        TriggerDictionary.Add(TriggerPosition, Which);
    end;

    procedure RunpageonModalMode()
    var
        PageAction: Action;
    begin
        PageAction := page.runmodal(page::"Item list");
        if Confirm('The action was %1 ', true, PageAction) then;
    end;

    procedure Runpage()
    begin
        page.run(page::"Item list");
        if Confirm('The page has closed... or??? ', true) then;
    end;

    procedure RunTestCodeunitModal()
    var
        WaitForMe: Boolean;
        CodeunitRunDemo: Codeunit Codeunit_A;

    begin
        CodeunitRunDemo.RaiseRuntimeError();
        WaitForMe := CodeunitRunDemo.Run();
        Error('CUERROR ' + Format(WaitForMe) + ' ' + GetLastErrorText());
    end;

    procedure RunTestCodeunit()
    begin
        Codeunit.Run(Codeunit::Codeunit_A);
        Error('Finished executing');
    end;

    var
        TriggerPosition: Integer;
        TriggerDictionary: Dictionary of [Integer, Text];

}
