import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PhoneNumber? phoneNumber = PhoneNumber.parse('+16505551234');

  @override
  Widget build(BuildContext context) {
    final phoneNumber = this.phoneNumber;
    return Scaffold(
      body: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            const SizedBox(height: 48),
            Text(
              'Try a phone number to see the parsing result below',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: phoneNumber?.international,
              decoration: const InputDecoration(
                label: Text('Phone number'),
              ),
              onChanged: (value) {
                try {
                  setState(() => this.phoneNumber = PhoneNumber.parse(value));
                } catch (e) {
                  setState(() => this.phoneNumber = null);
                }
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ListTile(
                          title: const Text('international'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber.international)
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Formatted national'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber.formatNsn(
                                  format: NsnFormat.national))
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Formatted international'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber.formatNsn(
                                  format: NsnFormat.international))
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Formatted with country code'),
                          trailing: phoneNumber != null
                              ? Text(
                                  phoneNumber.format(
                                    format: NsnFormat.international,
                                  ),
                                )
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Iso code'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber.isoCode.name)
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Country Dial Code'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber.countryCode)
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber.isValid().toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Mobile'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.mobile)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Fixed Line'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.fixedLine)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Voip'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.voip)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Toll-Free'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.tollFree)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Premium Rate'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.premiumRate)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Shared Cost'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.sharedCost)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Personal Number'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.personalNumber)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid UAN'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.uan)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Pager'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.pager)
                                  .toString())
                              : const Text('-'),
                        ),
                        ListTile(
                          title: const Text('Is Valid Voice Mail'),
                          trailing: phoneNumber != null
                              ? Text(phoneNumber
                                  .isValid(type: PhoneNumberType.voiceMail)
                                  .toString())
                              : const Text('-'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
