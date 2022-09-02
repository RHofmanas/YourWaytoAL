codeunit 50108 Codeunit_A
{
    trigger OnRun()
    begin
        Message('Codeunit A is executed');
        if RaiseError then
            Error('This Codeunit is executing AL code!');

        if Confirm('Done', true) then;
    end;


    procedure RaiseRuntimeError()
    begin
        RaiseError := true
    end;

    var
        RaiseError: Boolean;
}