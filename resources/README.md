# Updating LibPhoneNumber Metadata

The repo [marmelroy/PhoneNumberKit](https://github.com/marmelroy/PhoneNumberKit) does a good job of keeping the Metadata from LibPhoneNumber up to date.

This outlines the process of pulling/generating the Metadata JSON file from PhoneNumberKit, then copying to `dart_phone_number` and updating the Dart files.

This is a 3 step process:

1. Fetch/Generate LibPhoneNumber Metadata in JSON Format
2. Process the Metadata
3. Generate the Dart files

## 1. Copy phone number metadata

Copy this file https://github.com/marmelroy/PhoneNumberKit/blob/master/PhoneNumberKit/Resources/PhoneNumberMetadata.json into resources/data_sources/original_phone_number_metadata.json

## 2. Process Metadata

This will change the metadata to a format the library can understand easier

```
dart resources/data_sources/convert_metadata.dart
```

## 3. Generate Files

This is the final step to turn the Metadata into Dart Files.

```
pub get
dart resources/generate_files.dart && dart format lib/src && dart fix --apply
```