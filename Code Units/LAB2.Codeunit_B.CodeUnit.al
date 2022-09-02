codeunit 50101 Codeunit_B
{
    trigger OnRun()
    begin
        Initiate(Color);
        Message('Codeunit B was executed');
        Message('The value of %1 is: %2', 'Yes Or No?', Yes_Or_No);
        Message('The value of %1 is: %2', 'Amount', Amount);
        Message('The value of %1 is: %2', 'When was it?', When_was_it);
        Message('The value of %1 is: %2', 'What time?', What_time);
        Message('The value of %1 is: %2', 'Description', Description);
        Message('The value of %1 is: %2', 'Code Number', Code_Number);
        Message('The value of %1 is: %2', 'Character', Ch);
        Message('The value of %1 is: %2', 'Color Option', Color);
    end;

    procedure Initiate(Color: Option)
    begin
        Yes_Or_No := true;
        Amount := 1200.75;
        When_was_it := 20220808D;
        What_time := 103000T;
        Description := 'This stuff really works!!!';
        Code_Number := 'Hello';
        Ch := 'W';
        Color := 1;

    end;

    var
        Yes_Or_No: Boolean;
        Amount: Decimal;
        When_was_it: Date;
        What_time: Time;
        Description: Text;
        Code_Number: Code[20];
        Ch: Char;
        Color: Option Red,Green,Blue;

}
