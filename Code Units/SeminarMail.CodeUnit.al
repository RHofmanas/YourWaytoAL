#pragma warning disable LC0015
codeunit 50006 "Seminar Mail"
#pragma warning restore LC0015
{
    var
        SeminarRegistrationLine: Record "Seminar Registration Line";
        Customer: Record Customer;
        Contact: Record Contact;
        Mail: Codeunit Mail;
        MailSent: Boolean;

    procedure NewConfirmationMessage(var SeminarRegistrationLine_: Record "Seminar Registration Line")
    var
        CCName: Text;
    begin
        Contact.Get(SeminarRegistrationLine_."Participant Contact No.");
        Customer.Get(SeminarRegistrationLine_."Bill-to Customer No.");
        if Contact."E-Mail" = Customer."E-Mail" then
            CCName := ''
        else
            CCName := Customer."E-Mail";

        Mail.CreateMessage(Contact."E-Mail", CCName, '', 'Seminar Registration Confirmation', '', true, true);
        MailSent := Mail.Send();

        if MailSent then
            SeminarRegistrationLine_."Confirmation Date" := Today()
        else
            Mail.GetErrorDesc()
    end;

    procedure SendAllConfirmations(SeminarRegistrationHeader: Record "Seminar Registration Header")
    begin
        SeminarRegistrationLine.SetRange("Seminar Registration No.", SeminarRegistrationHeader."No.");
        if SeminarRegistrationLine.FindSet() then
            repeat
                NewConfirmationMessage(SeminarRegistrationLine);
            until SeminarRegistrationLine.Next() = 0;
    end;

}
