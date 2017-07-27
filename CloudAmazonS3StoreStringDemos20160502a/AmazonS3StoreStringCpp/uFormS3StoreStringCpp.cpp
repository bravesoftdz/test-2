//---------------------------------------------------------------------------

#include <fmx.h>
#include <Data.Cloud.AmazonAPI.hpp>
#pragma hdrstop

#include "uFormS3StoreStringCpp.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.fmx"
TFormS3StoreStringCpp *FormS3StoreStringCpp;
//---------------------------------------------------------------------------
__fastcall TFormS3StoreStringCpp::TFormS3StoreStringCpp(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
String BUCKET_NAME = "delphitest1";
String OBJ_NAME = "testobj1";
//---------------------------------------------------------------------------
void __fastcall TFormS3StoreStringCpp::btnUploadClick(TObject *Sender)
{
  TAmazonStorageService *s3 = new TAmazonStorageService(AmazonConnectionInfo1);
  TStringStream *strstr = new TStringStream(Edit1->Text);

  if (s3->UploadObject(BUCKET_NAME, OBJ_NAME, strstr->Bytes)) {
	ShowMessage("Uploaded OK");
  }
  else
	ShowMessage("ERROR Uploading");


  delete strstr;
  delete s3;
}
//---------------------------------------------------------------------------
void __fastcall TFormS3StoreStringCpp::btnDownloadClick(TObject *Sender)
{
  TAmazonStorageService *s3 = new TAmazonStorageService(AmazonConnectionInfo1);
  TStringStream *strstr = new TStringStream();

  if (s3->GetObject(BUCKET_NAME, OBJ_NAME, strstr)) {
	ShowMessage(strstr->DataString);
  }
  else
	ShowMessage("ERROR downloading");

  delete strstr;
  delete s3;
}
//---------------------------------------------------------------------------
