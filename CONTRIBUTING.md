# Contributing

## MetaData
phone_numbers_parser is using metadata from [Google's libphonenumber](https://github.com/googlei18n/libphonenumber).
We try to keep the metadata of phone_numbers_parser up to date and making sure you are running on the latest release will be sufficient for most apps. However, you can also update the metadata youself by following these 3 steps:

1. Download the XML file
2. Process the Metadata
3. Generate the Dart files

## 1. Copy phone number metadata

Copy this file https://github.com/googlei18n/libphonenumber/blob/master/resources/PhoneNumberMetadata.xml into resources/data_sources/PhoneNumberMetadata.xml

## 2. Process Metadata

This will change the metadata to a format the library can understand easier

```
dart resources/data_sources/convert_metadata.dart
```

## 3. Generate Files

This is the final step to turn the Metadata into Dart Files.

```
dart pub get
dart resources/generate_files.dart && dart format lib/src && dart fix --apply
```

## Line endings

`.gitattributes` stores text files with LF endings, so an editor that saves CRLF
does not turn a small change into a whole-file diff. Do not re-save a file only
to change its line endings: a pull request should contain real changes.
