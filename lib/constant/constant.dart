class Constants {
  static getBankName(String key) {
    if (key == 'cimb') {
      return 'CIMB';
    } else if (key == 'maybank') {
      return 'Maybank';
    } else if (key == 'bsn') {
      return 'BSN';
    } else if (key == 'bi') {
      return 'Bank Islam';
    } else {
      return key;
    }
  }
}
