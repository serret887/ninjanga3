import 'dart:async';

import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:observable/observable.dart';

const String discovery_service = "_googlecast._tcp";

class ServiceDiscovery extends ChangeNotifier {
  FlutterMdnsPlugin _mdnsPlugin;
  List<ServiceInfo> foundServices = [];

  ServiceDiscovery() {
    DiscoveryCallbacks discoveryCallbacks = new DiscoveryCallbacks(
      onDiscovered: (ServiceInfo info) {
        print("Service discovered $info");
      },
      onDiscoveryStarted: () {
        print("discovery started");
      },
      onDiscoveryStopped: () {
        print("discovery stopped");
      },
      onResolved: (ServiceInfo info) {
        print("found device ${info.toString()}");
        foundServices.add(info);
        notifyChange();
      },
    );
    _mdnsPlugin = new FlutterMdnsPlugin(discoveryCallbacks: discoveryCallbacks);
  }

  stopMdnsDiscovery() {
    _mdnsPlugin.stopDiscovery();
  }

  startGoogleChromeCastDiscovery() {
    _startMdnsDiscovery(discovery_service);
  }

  Future _startMdnsDiscovery(String serviceType) {
    // cannot directly start discovery, have to wait for ios to be ready first...
    Timer(Duration(seconds: 3), () => _mdnsPlugin.startDiscovery(serviceType));
  }
}
