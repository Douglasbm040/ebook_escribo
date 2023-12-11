
abstract class FailureRequestBook implements Exception {}

class InvalidateEndPointBook implements FailureRequestBook {}

abstract class FailureDownloadBook implements Exception {}
class InsertErrorBook implements FailureDownloadBook {}
class SelectErrorBook implements FailureDownloadBook {}
  
