class RecieptModel {
  String regno;
  List<RecieptDataList> recieptdata;

  RecieptModel({
    this.regno,
    this.recieptdata,
  });
}

class RecieptDataList {
  String chitno, fileurl, timeuploaded;

  RecieptDataList({this.chitno, this.fileurl, this.timeuploaded});
}
