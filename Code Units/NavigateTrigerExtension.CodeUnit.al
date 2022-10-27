#pragma warning disable LC0015
codeunit 50003 "Navigate Triger Extension"
#pragma warning restore LC0015
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure FindRecordsOnAfterNavigate(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        FindPstdSeminarRegHeader(DocumentEntry, DocNoFilter, PostingDateFilter);
        FindSeminarRegHeader(DocumentEntry, DocNoFilter, PostingDateFilter);
        FindSeminarLedgerEntries(DocumentEntry, DocNoFilter, PostingDateFilter);
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure ShowRecordsOnAfterNavigate(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary)

    begin
        case TempDocumentEntry."Table ID" of
            Database::"Seminar Registration Header":
                begin
                    SeminarRegistrationHeader.Reset();
                    SeminarRegistrationHeader.SetCurrentKey("No.", "Posting Date");
                    SeminarRegistrationHeader.SetFilter("No.", DocNoFilter);
                    SeminarRegistrationHeader.SetFilter("Posting Date", PostingDateFilter);
                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Seminar Registration", SeminarRegistrationHeader)
                    else
                        Page.Run(0, SeminarRegistrationHeader);
                end;
            Database::"Posted Seminar Reg. Header":
                begin
                    PostedSeminarRegHeader.Reset();
                    PostedSeminarRegHeader.SetCurrentKey("No.", "Posting Date");
                    PostedSeminarRegHeader.SetFilter("No.", DocNoFilter);
                    PostedSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);

                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Posted Seminar Registration", PostedSeminarRegHeader)
                    else
                        Page.Run(0, PostedSeminarRegHeader);
                end;
            Database::"Seminar Ledger Entry":
                begin
                    SeminarLedgerEntry.Reset();
                    SeminarLedgerEntry.SetCurrentKey("Document No.", "Posting Date");
                    SeminarLedgerEntry.SetFilter("Document No.", DocNoFilter);
                    SeminarLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Seminar Ledger Entries", SeminarLedgerEntry)
                    else
                        Page.Run(0, SeminarLedgerEntry);
                end;
        end;
    end;

    local procedure FindSeminarLedgerEntries(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if SeminarLedgerEntry.ReadPermission() then begin
            SeminarLedgerEntry.Reset();
            SeminarLedgerEntry.SetCurrentKey("Document No.");
            SeminarLedgerEntry.SetFilter("Document No.", DocNoFilter);
            SeminarLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"Value Entry",
            SeminarLedgerEntry.TableCaption, SeminarLedgerEntry.Count);
        end;
    end;

    local procedure FindPstdSeminarRegHeader(var DocumentEntry: Record "Document Entry";
        DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if PostedSeminarRegHeader.ReadPermission() then begin
            PostedSeminarRegHeader.Reset();
            PostedSeminarRegHeader.SetFilter("No.", DocNoFilter);
            PostedSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"Posted Seminar Reg. Header",
            PostedSeminarRegHeader.TableCaption, // <----PstdSeminarRegHeader.TableCaption from PstdSeminarRegHeaderTxt
            PostedSeminarRegHeader.Count);
        end;
    end;

    local procedure FindSeminarRegHeader(var DocumentEntry: Record "Document Entry";
        DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if SeminarRegistrationHeader.ReadPermission() then begin
            SeminarRegistrationHeader.Reset();
            SeminarRegistrationHeader.SetFilter("No.", DocNoFilter);
            SeminarRegistrationHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"Seminar Registration Header",
            SeminarRegistrationHeader.TableCaption, // <----SeminarRegHeader.TableCaption from SeminarRegHeaderTxt
            SeminarRegistrationHeader.Count);   // <----SeminarRegHeader.Count from PstdSeminarRegHeader.Count
        end;
    end;

    local procedure InsertIntoDocEntry(var DocumentEntry: Record "Document Entry"; DocTableID: Integer; DocTableName: Text; DocNoOfRecords: Integer)
    begin
        if DocNoOfRecords = 0 then
            exit;

        DocumentEntry.Init();
        DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
        DocumentEntry."Table ID" := DocTableID;
        DocumentEntry."Document Type" := DocumentEntry."Document Type"::" ";
        DocumentEntry."Table Name" := CopyStr(DocTableName, 1, MaxStrLen(DocumentEntry."Table Name"));
        DocumentEntry."No. of Records" := DocNoOfRecords;
        DocumentEntry.Insert();
    end;

    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
}
