import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sos_sig/blocs/blocs.dart';
import 'package:sos_sig/services/services.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final alarmaService = Provider.of<AlarmaService>(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 70, left: 20, child: _BtnBack()),

           Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                  from: 100,
                  child: const Icon(Icons.location_on_rounded, size: 60)),
            ),
          ), 

          // Boton de confirmar
          Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  minWidth: size.width - 120,
                  child: const Text('Enviar Ubicacion',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  color: Colors.black,
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    // Todo: loading
                    final end = mapBloc.mapCenter;
                    if (end == null) return;
                    alarmaService.selectedAlarmas.latitud = end.latitude;
                    alarmaService.selectedAlarmas.longitud = end.longitude;
                    final destination = await alarmaService
                        .createAlarma(alarmaService.selectedAlarmas);
                    print(destination);
                    
                    //Navigator.pop(context);
                     Navigator.pushNamed(context, 'home');
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            /* BlocProvider.of<SearchBloc>(context)
                .add(OnDeactivateManualMarkerEvent()); */
            Navigator.pushNamed(context, 'home');
          },
        ),
      ),
    );
  }
}
