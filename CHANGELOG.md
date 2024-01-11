## 0.5.0

- Replaced the `HTTP.Client` with `Dio`.
- Supported get `AsyncTextGeneration` Operation status.
- Removed `ApiCancelToken`.
- Replaced `AuthToken.value` with `AuthToken.toString()`. 
- Converted `YandexGptApi` into its implementation `YandexGptApiClient`.
- Renamed `TextGenerationResponse` into `TextCompletion`.

## 0.4.0

- Removed HTTP errors handling.
- Removed HTTP errors models.
- Added ability to change `YandexGptApi` token.
- Added support of IAM token and API key.

## 0.3.2

- Minor fixes.

## 0.3.1

- Fix GPT models URI.

## 0.3.0

- Added GPT models classes.
- Replaced in requests `modelUri` param with `AiModel` classes.

## 0.2.6

- Add role constructors for `Message`.
- Change README.md docs.

## 0.2.5

- Change README.md

## 0.2.4

- Added tests for `TextGenerationAsync`.
- Increased test coverage to 100%.

## 0.2.3

- Fixed errors by closing requests with `ApiCancelToken`.
- Add tests for `ApiCancelToken`.

## 0.2.2

- Add tests for `YandexGptApiClient` - handling successful response and json conversion.

## 0.2.1

- Add tests for `YandexGptHttpClient` - handling errors and successful response.

## 0.2.0

- Divided `ContractApiError` into `DetailedApiError` and `ShortApiError`.

## 0.1.0

- Receiving data from the API.
- Asynchronous generation and receipt of normal error statuses does not work. The signature of the
  methods may change.
