//---------------------------------------------------------------------------

#ifndef uFormS3StoreStringCppH
#define uFormS3StoreStringCppH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <Data.Cloud.AmazonAPI.hpp>
#include <Data.Cloud.CloudAPI.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Types.hpp>
#include <FMX.StdCtrls.hpp>
//---------------------------------------------------------------------------
class TFormS3StoreStringCpp : public TForm
{
__published:	// IDE-managed Components
	TEdit *Edit1;
	TButton *btnUpload;
	TButton *btnDownload;
	TAmazonConnectionInfo *AmazonConnectionInfo1;
	void __fastcall btnUploadClick(TObject *Sender);
	void __fastcall btnDownloadClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TFormS3StoreStringCpp(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormS3StoreStringCpp *FormS3StoreStringCpp;
//---------------------------------------------------------------------------
#endif
