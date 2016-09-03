// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
/*@TestOn('browser')
import 'package:angular2/angular2.dart'
    show
    Component,
    View,
    NgFor,
    provide,
    Inject,
    Injectable,
    Optional,
    Provider,
    DebugElement,
    Directive;

import 'package:angular2/src/mock/mock_application_ref.dart';

import 'package:angular2/router.dart' show RouterLink;

import 'package:test/test.dart';
import 'package:angular2_testing/angular2_testing.dart';
import 'package:songwoof/common/components/player/player.dart';
import 'package:songwoof/common/components/cover/cover.dart';
import 'package:songwoof/common/components/md_icon/md_icon.dart';
import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/common/soundcloud/soundcloud_player.dart';
import 'package:songwoof/common/soundcloud/soundcloud_interop.dart';
import 'dart:html' as dom;
import 'dart:async';

bool playCalled = false;
bool pauseCalled = false;
bool stopCalled = false;
bool isPlayingCalled = false;

bool returnValueIsPlaying = true;

@Injectable()
class MockPlayer implements SoundCloudPlayer {

  @override bool isPlaying() {isPlayingCalled = true; return returnValueIsPlaying;}

  final StreamController _onEndedController = new StreamController.broadcast();
  @override Stream get onEnded => _onEndedController.stream;

  @override void pause() { pauseCalled = true; }

  @override void play(Track track) { playCalled = true; }

  @override void stop() { stopCalled = true; }
}

@Injectable()
class MockSoundCloudAudio implements SoundCloudAudio {

  @override off(String event, Function callback) {}

  @override on(String event, Function callback) {}

  @override pause() {}

  @override play(Options) {}

  @override get playing => null;

  @override stop() {}

  @override unbindAll() {}
}

void main() {
  initAngularTests();

  setUpProviders(() => [
    provide(SoundCloudAudio, useClass: MockSoundCloudAudio),
    provide(SoundCloudPlayer, useClass: MockPlayer)
  ]);

  group('Player Component', () {

    ngTest('should use mock of SoundCloudPlayer', (SoundCloudPlayer player) async {
      expect(player, new isInstanceOf<MockPlayer>());
    });

    group('When component is initialized', () {
      SwoofPlayerComponent playerComponent;
      dom.Element playerElement;
      ComponentFixture rootTC;

      ngSetUp((TestComponentBuilder tcb) async {
        Uri uri = new Uri.file(
            'packages/songwoof/common/components/player/player.html');
        String template = await dom.HttpRequest.getString(uri.toString());
        rootTC = await tcb
            .overrideTemplate(SwoofPlayerComponent, template)
            .overrideDirective(SwoofPlayerComponent, CoverComponent, Dummy)
            .overrideDirective(SwoofPlayerComponent, MdIconComponent, Dummy)
            .overrideProviders(SwoofPlayerComponent, [provide(SoundCloudPlayer, useClass: MockPlayer)])
            .createAsync(SwoofPlayerComponent);

        playerComponent = rootTC.debugElement.componentInstance;
        playerElement = rootTC.debugElement.nativeElement;

        Track dummyTrack = new Track()..artworkUrl = 'dummy.jpg';
        Track dummyTrack2 = new Track()..artworkUrl = 'dummy2.jpg';
        List<Track> dummyTracks = [dummyTrack, dummyTrack2];

        playerComponent.track = dummyTracks[0];
        playerComponent.trackList = dummyTracks;

        rootTC.detectChanges();
      });

      ngTest('should be defined', () async {
        expect(playerComponent, isNotNull);
        expect(playerElement, isNotNull);
      });

      tearDown(() {
        cleanPlayerState();
        playerComponent.track = playerComponent.trackList[0];
      });

      group('#isPlaying()', () {
        ngTest('should call SoundCloudPlayer.isPlaying()', () async {
          playerComponent.isPlaying();
          expect(isPlayingCalled, equals(true));
        });
      });

      group('#isPlaying()', () {
        ngTest('should call SoundCloudPlayer.isPlaying()', () async {
          playerComponent.isPlaying();
          expect(isPlayingCalled, equals(true));
        });
      });

      group('#ngOnDestroy()', () {
        ngTest('should call SoundCloudPlayer.stop()', () async {
          playerComponent.ngOnDestroy();
          expect(stopCalled, equals(true));
        });
      });

      group('#togglePlay()', () {
        ngTest('should call SoundCloudPlayer.pause() when playing', () async {
          returnValueIsPlaying = true;

          playerComponent.togglePlay();
          expect(isPlayingCalled, equals(true));
          expect(pauseCalled, equals(true));
        });

        ngTest('should call SoundCloudPlayer.play() when is not playing', () async {
          returnValueIsPlaying = false;

          playerComponent.togglePlay();
          expect(isPlayingCalled, equals(true));
          expect(playCalled, equals(true));
        });
      });

      group('#dismiss()', () {
        ngTest('should call SoundCloudPlayer.play() when there is a next track', () async {
          playerComponent.dismiss();
          expect(playCalled, equals(true));
        });
      });

      group('#favorite()', () {
        ngTest('should emit the current track onFavorite event', () async {
          playerComponent.track = new Track()..artworkUrl = 'fav.jpg';
          playerComponent.onFavorite.listen((t){
            expect(playerComponent.track.artworkUrl, equals(t.artworkUrl));
          });

          playerComponent.favorite();
          rootTC.detectChanges();

        });
      });
    });
  });
}

@Directive(selector: '[routerLink]')
class Dummy {}

void cleanPlayerState() {
  playCalled = false;
  pauseCalled = false;
  stopCalled = false;
  isPlayingCalled = false;
}*/