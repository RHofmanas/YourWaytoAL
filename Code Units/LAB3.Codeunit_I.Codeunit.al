Codeunit 50103 "Codeunit_I"
{
    trigger OnRun()
    begin
        Message('Codeunit I was executed');
        CodeA := 'HELLO THERE';
        TextA := 'How are you? ';
        CodeB := CodeA + '. ' + TextA;
        Message('The value of %1 is %2', 'CodeB', CodeB);
        MaxChar := MaxStrLen(Description);
        Message('The value of %1 is %2', 'MaxChar', MaxChar);
        Description := CopyStr('The message is: ' + CodeB, 1, MaxStrLen(Description));
        Message('The value of %1 is %2', 'Description', Description);
    end;

    var
        CodeA: Code[30];
        CodeB: Code[50];
        TextA: Text[50];
        textB: Text[80];
        MaxChar: Integer;
        Description: Text[30];
}