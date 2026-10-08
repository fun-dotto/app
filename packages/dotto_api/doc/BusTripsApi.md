# openapi.api.BusTripsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**busTripsV1List**](BusTripsApi.md#bustripsv1list) | **GET** /v1/busTrips | 


# **busTripsV1List**
> BusTripsV1List200Response busTripsV1List(date)



バスの運行情報を取得する

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: FirebaseAppCheckAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('FirebaseAppCheckAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('FirebaseAppCheckAuth').apiKeyPrefix = 'Bearer';

final api = Openapi().getBusTripsApi();
final Date date = 2013-10-20; // Date | バスの運行情報を取得する日付

try {
    final response = api.busTripsV1List(date);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BusTripsApi->busTripsV1List: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**| バスの運行情報を取得する日付 | 

### Return type

[**BusTripsV1List200Response**](BusTripsV1List200Response.md)

### Authorization

[FirebaseAppCheckAuth](../README.md#FirebaseAppCheckAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

