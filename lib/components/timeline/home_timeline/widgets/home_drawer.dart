import 'package:flutter/material.dart';
import 'package:harpy/components/authentication/bloc/authentication_bloc.dart';
import 'package:harpy/components/authentication/bloc/authentication_event.dart';
import 'package:harpy/components/common/flare_icons.dart';
import 'package:harpy/components/common/harpy_background.dart';
import 'package:harpy/components/timeline/home_timeline/widgets/home_drawer_header.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer();

  Widget _buildActions(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              // profile
              ListTile(
                leading: const Icon(Icons.face),
                title: const Text('Profile'),
                onTap: () {},
              ),

              const Divider(),

              // settings
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),

              // harpy pro
              ListTile(
                leading: const FlareIcon.shiningStar(
                  size: 30,
                  offset: Offset(-2.5, 0),
                ),
                title: const Text('Harpy Pro'),
                onTap: () {},
              ),

              // about
              ListTile(
                leading: const FlareIcon.harpyLogo(),
                title: const Text('About'),
                onTap: () {},
              ),
            ],
          ),
        ),
        // logout
        ListTile(
          leading: const Icon(Icons.arrow_back),
          title: const Text('Logout'),
          onTap: () => AuthenticationBloc.of(context).add(const LogoutEvent()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: HarpyBackground(
        child: Column(
          children: <Widget>[
            const HomeDrawerHeader(),
            Expanded(child: SafeArea(child: _buildActions(context))),
          ],
        ),
      ),
    );
  }
}
