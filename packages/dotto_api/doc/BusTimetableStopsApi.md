# openapi.api.BusTimetableStopsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**busTimetableStopsV1List**](BusTimetableStopsApi.md#bustimetablestopsv1list) | **GET** /v1/busTrips/{tripId}/busTimetableStops | 


# **busTimetableStopsV1List**
> BusTimetableStopsV1List200Response busTimetableStopsV1List(tripId)



バスの停車情報を取得する

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: FirebaseAppCheckAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('FirebaseAppCheckAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('FirebaseAppCheckAuth').apiKeyPrefix = 'Bearer';

final api = Openapi().getBusTimetableStopsApi();
final String tripId = tripId_example; // String | 運行ID

try {
    final response = api.busTimetableStopsV1List(tripId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BusTimetableStopsApi->busTimetableStopsV1List: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tripId** | **String**| 運行ID | 

### Return type

[**BusTimetableStopsV1List200Response**](BusTimetableStopsV1List200Response.md)

### Authorization

[FirebaseAppCheckAuth](../README.md#FirebaseAppCheckAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

