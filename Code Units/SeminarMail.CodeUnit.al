codeunit 50006 "Seminar Mail"
{
    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";
        Customer: Record Customer;
        Contact: Record Contact;
        Mail: Codeunit Mail;
        NumberOfErrors: Integer;
        MailSent: Boolean;
        EMailConfirmation: Text;
        SubjectLine: Text;
        Greeting: Text;
        ConfirmationSentence: Text;
        Signature: Text;

    procedure NewConfirmationMessage(var SeminarRegLine: Record "Seminar Registration Line")
    var
        CCName: Text;
    begin
        Contact.Get(SeminarRegLine."Participant Contact No.");
        Customer.Get(SeminarRegLine."Bill-to Customer No.");
        if Contact."E-Mail" = Customer."E-mail" then
            CCName := ''
        else
            CCName := Customer."E-Mail";

        Mail.CreateMessage(Contact."E-Mail", CCName, '', 'Seminar Registration Confirmation', '', true, true);
        MailSent := Mail.Send();

        if MailSent then
            SeminarRegLine."Confirmation Date" := Today()
        else
            Mail.GetErrorDesc()
    end;

    procedure SendAllConfirmations(SeminarRegHeader: Record "Seminar Registration Header")
    begin
        SeminarRegLine.SetRange("Seminar Registration No.", SeminarRegHeader."No.");
        if SeminarRegLine.FindSet() then
            repeat
                NewConfirmationMessage(SeminarRegLine);
            until SeminarRegLine.Next() = 0;
    end;

}
