codeunit 50102 Codeunit_C
{
    trigger OnRun()
    begin
        Message('Codeunit C was executed');
        CodeA := 'HELLO THERE';
        TextA := 'How are you? ';
        CodeB := CodeA + '. ' + TextA;
        Message('The value of %1 is %2', 'CodeB', CodeB);
    end;

    var
        CodeA: Code[30];
        CodeB: Code[50];
        TextA: Text[50];
        textB: Text[80];
}
