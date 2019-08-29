//TODO is not supporting the Apple Bonjour and open source Avahi software packages
// in the current implementation and it also can break so I am going to
// go deeper in package that i am using and see what are the dependencies to
// the bellow package and how i can use the further one
// this change will allow me to use apple TV, and maybe firestick
import 'package:multicast_dns/multicast_dns.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('''
Please provide the name of a service as argument.
For example:
  dart mdns-sd.dart [--verbose] _workstation._tcp.local''');
    return;
  }

  final bool verbose = args.contains('--verbose') || args.contains('-v');
  final String name = args.last;
  final MDnsClient client = MDnsClient();
  await client.start();

  await for (PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    if (verbose) {
      print(ptr);
    }
    await for (SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      if (verbose) {
        print(srv);
      }
      if (verbose) {
        await client
            .lookup<TxtResourceRecord>(ResourceRecordQuery.text(ptr.domainName))
            .forEach(print);
      }
      await for (IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target))) {
        if (verbose) {
          print(ip);
        }
        print('Service instance found at '
            '${srv.target}:${srv.port} with ${ip.address}.');
      }
      await for (IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv6(srv.target))) {
        if (verbose) {
          print(ip);
        }
        print('Service instance found at '
            '${srv.target}:${srv.port} with ${ip.address}.');
      }
    }
  }
  client.stop();
}
