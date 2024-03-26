// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persing/constants.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/comentario.dart';
import 'package:persing/providers/publicacion.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:persing/screens/publicaciones/publicaciones_by_sector.dart';
import 'package:persing/widgets/comments_screen.dart';
import 'package:persing/widgets/custom_icons.dart';
import 'package:persing/widgets/popup_menu_tile.dart';
import 'package:persing/widgets/video_widget.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ignore: must_be_immutable
class PublicationCard extends StatefulWidget {
  PublicationCard({
    required this.imageUrl,
    required this.videoUrl,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    required this.guardados,
    required this.likes,
    required this.empresaLogo,
    required this.comentarios,
    required this.nombreEmpresa,
    required this.postId,
    this.liked,
    this.saved,
    this.sector,
    this.link,
    this.isDestacado = false,
    this.seccion = false,
    this.isNew,
    this.idSection = '',
    this.nombreSection = '',
    this.usuarioId = '',
    this.isEmpresa = '',
    this.showMore = false,
    this.onLiked,
    this.onSaved,
    super.key,
  });

  final String isEmpresa;
  final String imageUrl;
  final String videoUrl;
  final String titulo;
  final String fecha;
  final String descripcion;
  final List<String> guardados;
  final bool? isNew;
  final String idSection;
  final String nombreSection;
  int likes;
  final String empresaLogo;
  final int comentarios;
  final String nombreEmpresa;
  final String postId;
  bool? liked;
  bool? saved;
  bool seccion;
  final String? sector;
  final String? link;
  final bool isDestacado;
  final String usuarioId;

  final VoidCallback? onLiked;

  final Function(String)? onSaved;

  /// To show or hide 'Ver más'option on card popup menu.
  final bool showMore;

  @override
  _PublicationCardState createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCard>
    with AutomaticKeepAliveClientMixin {
  bool isWatching = false;
  Stopwatch sw = Stopwatch();
  ValueNotifier<bool> isSaved = ValueNotifier(false);
  ValueNotifier<bool> viewed = ValueNotifier(false);
  ValueNotifier<bool> isLiked = ValueNotifier(false);
  ValueNotifier<int> likesCount = ValueNotifier(0);
  ValueNotifier<int> commentNo = ValueNotifier(0);
  bool ignored = true;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  bool get wantKeepAlive => false;

  _navigateComments(BuildContext context) async {
    ignored = false;
    if (!widget.isDestacado) {
      Provider.of<Publicacion>(context, listen: false)
        ..addInteraction(widget.postId)
        ..updateEngagement(widget.postId);
    }

    if (widget.isNew == true) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(
            isNew: true,
            postId: widget.postId,
            sector: widget.sector ?? '',
            seccion: widget.seccion,
            isDestacado: widget.isDestacado,
            idSection: widget.idSection,
            nombreSection: widget.nombreSection,
          ),
        ),
      );
      return;
    }

    if (widget.idSection.isNotEmpty) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(
            isNew: false,
            postId: widget.postId,
            sector: widget.sector ?? "",
            seccion: widget.seccion,
            isDestacado: widget.isDestacado,
            idSection: widget.idSection,
            nombreSection: widget.nombreSection,
          ),
        ),
      );
      return;
    }
    if (widget.usuarioId.isNotEmpty) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(
            isNew: widget.isNew ?? false,
            postId: widget.postId,
            sector: widget.sector ?? "",
            seccion: widget.seccion,
            isDestacado: widget.isDestacado,
            idSection: widget.idSection,
            nombreSection: widget.nombreSection,
            userId: widget.usuarioId,
          ),
        ),
      );
      return;
    }
    if (widget.isEmpresa.isNotEmpty) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(
            isEmpresa: widget.isEmpresa,
            isNew: widget.isNew ?? false,
            postId: widget.postId,
            sector: widget.sector ?? '',
            seccion: widget.seccion,
            isDestacado: widget.isDestacado,
            idSection: widget.idSection,
            nombreSection: widget.nombreSection,
            userId: widget.usuarioId,
          ),
        ),
      );
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(
          isNew: false,
          postId: widget.postId,
          sector: widget.sector ?? '',
          seccion: widget.seccion,
          isDestacado: widget.isDestacado,
          idSection: '',
          nombreSection: '',
        ),
      ),
    );
    final commentsProvider = Provider.of<Comentario>(context, listen: false);
    final comments = await Future.value(
      commentsProvider.fetchComments(widget.postId),
    );
    commentNo.value = comments.length;
  }

  @override
  void dispose() {
    startTimeout().cancel();
    super.dispose();
  }

  _toggleLikeDestacado(BuildContext context) async {
    ignored = false;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    if (widget.likes.toString().contains(userId!) || isLiked.value) {
      await Provider.of<Publicacion>(context, listen: false)
          .toggleLikeDestacado(widget.postId, "remove", widget.seccion)
          .then(
        (value) {
          Provider.of<Publicacion>(context, listen: false)
              .toggleLikeDestacados();
          if (isLiked.value) {
            likesCount.value--;
          } else {
            likesCount.value++;
          }
          isLiked.value = !isLiked.value;
          widget.liked = isLiked.value;
          widget.onLiked?.call();
        },
      );
      if (!widget.isDestacado) {
        Provider.of<Publicacion>(context, listen: false)
          ..addInteraction(widget.postId)
          ..updateEngagement(widget.postId);
      }

      !widget.seccion
          ? Provider.of<Recompensa>(context, listen: false)
              .recordInteraction(widget.postId, widget.sector ?? '', "dislike")
          :
          // ignore: unnecessary_statements
          null;
    } else {
      Provider.of<Publicacion>(context, listen: false).toggleLikeDestacados();
      await Provider.of<Publicacion>(context, listen: false)
          .toggleLikeDestacado(widget.postId, "add", widget.seccion)
          .then(
        (value) {
          if (isLiked.value) {
            likesCount.value--;
          } else {
            likesCount.value++;
          }
          isLiked.value = !isLiked.value;
          widget.liked = isLiked.value;
          widget.onLiked?.call();
        },
      );
      if (!widget.isDestacado) {
        Provider.of<Publicacion>(context, listen: false)
          ..addInteraction(widget.postId)
          ..updateEngagement(widget.postId);
      }
      Provider.of<Recompensa>(context, listen: false);
      !widget.seccion
          ? Provider.of<Recompensa>(context, listen: false)
              .recordInteraction(widget.postId, widget.sector ?? '', "like")
          :
          // ignore: unnecessary_statements
          null;
    }
  }

  _toggleLike(BuildContext context) async {
    ignored = false;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    if (widget.likes.toString().contains(userId!) || isLiked.value) {
      await Provider.of<Publicacion>(context, listen: false)
          .toggleLike(widget.postId, "remove")
          .then(
        (value) {
          Provider.of<Publicacion>(context, listen: false)
              .toggleLikeDestacados();
          if (isLiked.value) {
            likesCount.value--;
          } else {
            likesCount.value++;
          }
          isLiked.value = !isLiked.value;
          widget.liked = isLiked.value;
          widget.onLiked?.call();
        },
      );
      Provider.of<Recompensa>(context, listen: false)
          .recordInteraction(widget.postId, widget.sector ?? '', "dislike");
      Provider.of<Publicacion>(context, listen: false)
        ..addInteraction(widget.postId)
        ..updateEngagement(widget.postId);

      isLiked.value = false;
    } else {
      Provider.of<Publicacion>(context, listen: false).toggleLikeDestacados();
      await Provider.of<Publicacion>(context, listen: false)
          .toggleLike(widget.postId, "add")
          .then(
        (value) {
          if (isLiked.value) {
            likesCount.value--;
          } else {
            likesCount.value++;
          }
          isLiked.value = !isLiked.value;
          widget.liked = isLiked.value;
          widget.onLiked?.call();
        },
      );
      Provider.of<Recompensa>(context, listen: false)
          .recordInteraction(widget.postId, widget.sector ?? '', "like");
      Provider.of<Publicacion>(context, listen: false)
        ..addInteraction(widget.postId)
        ..updateEngagement(widget.postId);
    }
  }

  _toggleSave(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    ignored = false;
    if (widget.guardados.toString().contains(userId!) || isSaved.value) {
      Provider.of<Publicacion>(context, listen: false)
          .toggleSave(widget.postId, "remove")
          .then((value) {
        isSaved.value = false;
        widget.guardados.remove(userId);
        widget.onSaved?.call(userId);
      });
      Provider.of<Publicacion>(context, listen: false)
        ..addInteraction(widget.postId)
        ..updateEngagement(widget.postId);
    } else {
      Provider.of<Publicacion>(context, listen: false)
          .toggleSave(widget.postId, "add")
          .then((value) {
        isSaved.value = true;
        widget.guardados.add(userId);
        widget.onSaved?.call(userId);
      });
      Provider.of<Publicacion>(context, listen: false)
        ..addInteraction(widget.postId)
        ..updateEngagement(widget.postId);
      Provider.of<Recompensa>(context, listen: false)
          .recordInteraction(widget.postId, widget.sector ?? '', "guardar");
    }
  }

  void _sumSharePoints() {
    ignored = false;
    Provider.of<Recompensa>(context, listen: false)
        .recordInteraction(widget.postId, widget.sector ?? '', "compartir");
  }

  void customShare(BuildContext ctx) {
    ignored = false;
    final responsive = ResponsiveDesign(ctx);
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          Provider.of<Publicacion>(context, listen: false)
            ..addInteraction(widget.postId)
            ..updateEngagement(widget.postId);
          return Container(
            margin: EdgeInsets.all(10),
            height: 80 + responsive.paddingBottom,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Selecciona una app para compartir",
                    style: TextStyle(
                      fontSize: 15,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.whatsapp,
                            size: 30, color: primaryColor),
                        onPressed: () {
                          SocialShare.shareWhatsapp(
                                  "He encontrado este anuncio que puede interesarte: ${widget.link}")
                              .whenComplete(() => _sumSharePoints());
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.facebook,
                            size: 30, color: primaryColor),
                        onPressed: () async {
                          final cache = DefaultCacheManager();
                          final file =
                              await cache.getSingleFile(widget.imageUrl);

                          Platform.isAndroid
                              ? SocialShare.shareFacebookStory(
                                  appId: '15578',
                                  imagePath: file.path,
                                  backgroundTopColor: "#ffffff",
                                  backgroundBottomColor: "#ffffff",
                                  attributionURL: widget.link,
                                ).then((data) {})
                              : SocialShare.shareFacebookStory(
                                  appId: '15578',
                                  imagePath: file.path,
                                  backgroundTopColor: "#ffffff",
                                  backgroundBottomColor: "#ffffff",
                                  attributionURL: widget.link,
                                ).then((data) {});
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.instagram,
                            size: 30, color: primaryColor),
                        onPressed: () async {
                          try {
                            final cache = DefaultCacheManager();
                            final file =
                                await cache.getSingleFile(widget.imageUrl);

                            SocialShare.shareInstagramStory(
                                appId: '15578', imagePath: file.path);
                          } catch (error) {}
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.twitter,
                            size: 30, color: primaryColor),
                        onPressed: () {
                          SocialShare.shareTwitter(
                            "He encontrado este anuncio que puede interesarte:",
                            url: widget.link,
                          ).then((value) => print(value));
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.telegramPlane,
                            size: 30, color: primaryColor),
                        onPressed: () async {
                          await SocialShare.shareTelegram(
                                  "He encontrado este anuncio que puede interesarte: ${widget.link}")
                              .then((value) => print(value));
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.copy,
                            size: 30, color: primaryColor),
                        onPressed: () async {
                          await SocialShare.copyToClipboard(text: widget.link);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void startWatchTime() {
    isWatching = true;
    sw.start();
  }

  Timer startTimeout() {
    const timeout = Duration(seconds: 10);
    return Timer(timeout, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    startTimeout().cancel();
    viewed.value = true;
    if (mounted) {
      ignored = false;

      Provider.of<Publicacion>(context, listen: false).addView(widget.postId);
    }
  }

  void stopTimeout() {
    // callback function
    if (mounted) {
      startTimeout().cancel();
      viewed.value = false;
    }
  }

  void stopWatchTime(context, String sectorId) {
    if (widget.videoUrl.isEmpty) {
      isWatching = false;
      sw.stop();
      final elapsed =
          double.parse((sw.elapsedMilliseconds / 1000).toStringAsFixed(2));
      sw.reset();

      try {
        Provider.of<Recompensa>(context, listen: false)
            .saveWatchedTime(widget.postId, widget.sector ?? '', elapsed);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void _recordAdClick() {
    Provider.of<Publicacion>(context, listen: false)
      ..adClicked(widget.postId)
      ..updateCtr(widget.postId);
  }

  Future<void> _launchURL() async {
    final uri = Uri.parse(widget.link ?? '');
    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _validateLikeAndSaves() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    if (widget.guardados.isNotEmpty) {
      if (widget.guardados.toString().contains(userId ?? "")) {
        isSaved.value = true;
      } else {
        isSaved.value = false;
      }
    }
  }

  @override
  void initState() {
    _validateLikeAndSaves();
    isLiked.value = widget.liked ?? false;
    isSaved.value = (widget.saved ?? false) ||
        (widget.guardados ?? []).contains(widget.usuarioId);
    likesCount.value = widget.likes ?? 0;
    commentNo.value = widget.comentarios;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final responsive = ResponsiveDesign(context);
    return VisibilityDetector(
      key: Key('visibility-' + '${widget.postId}'),
      onVisibilityChanged: (visibilityInfo) {
        int visiblePercentage = (visibilityInfo.visibleFraction * 100).floor();
        if (visiblePercentage >= 80 &&
            !isWatching &&
            widget.videoUrl.isEmpty &&
            !widget.isDestacado) {
          startWatchTime();
          startTimeout();
        } else if (visiblePercentage <= 40 &&
            isWatching &&
            widget.videoUrl.isEmpty &&
            !widget.isDestacado) {
          if (ignored == true && !widget.isDestacado ||
              widget.postId.isEmpty) {}
          stopWatchTime(context, widget.sector ?? '');
          stopTimeout();
        }
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Card(
            color: Colors.grey[50],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: FadeInImage(
                              alignment: Alignment.center,
                              image: CachedNetworkImageProvider(
                                widget.empresaLogo,
                              ),
                              placeholder: CachedNetworkImageProvider(
                                'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Container(
                                  width: responsive.widthMultiplier(
                                    widget.isDestacado ? 260 : 150,
                                  ),
                                  child: Text(
                                    widget.nombreEmpresa,
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Text(
                                widget.fecha,
                                style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ],
                      ),
                      (!widget.isDestacado)
                          ? PopupMenuButton(
                              child: Icon(
                                FontAwesomeIcons.ellipsisH,
                                color: primaryColor,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: PopUpMenuTile(
                                    isActive: false,
                                    icon: CustomIcons.comment,
                                    title: 'Comentar',
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: PopUpMenuTile(
                                    isActive: false,
                                    icon: isLiked.value ?? false
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    title: isLiked.value ?? false
                                        ? 'Eliminar de favoritos'
                                        : 'Agregar a favoritos',
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: PopUpMenuTile(
                                    isActive: false,
                                    icon: CustomIcons.share,
                                    title: 'Compartir',
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 3,
                                  child: PopUpMenuTile(
                                    isActive: true,
                                    icon: widget.saved ?? false
                                        ? Icons.bookmark_remove_outlined
                                        : Icons.bookmark_add_outlined,
                                    title: widget.saved ?? false
                                        ? 'Eliminar de guardados'
                                        : 'Guardar',
                                  ),
                                ),
                                if (widget.showMore)
                                  PopupMenuItem<int>(
                                    value: 4,
                                    child: PopUpMenuTile(
                                      isActive: false,
                                      icon: Icons.add,
                                      title: 'Ver más',
                                    ),
                                  ),
                              ],
                              onSelected: (value) async {
                                switch (value) {
                                  case 0:
                                    await _navigateComments(context);
                                    break;
                                  case 1:
                                    if (widget.isDestacado) {
                                      await _toggleLikeDestacado(context);
                                    } else {
                                      await _toggleLike(context);
                                    }
                                    break;
                                  case 2:
                                    SocialShare.shareOptions(
                                      "He encontrado este anuncio que puede interesarte: ${widget.videoUrl}",
                                    ).then(
                                      (data) {},
                                    );
                                    break;
                                  case 3:
                                    _toggleSave(context);
                                    break;
                                  case 4:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PublicacionesBySector(
                                          sectorId: widget.sector ?? '',
                                        ),
                                      ),
                                    );

                                    break;
                                  default:
                                }
                              },
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                widget.imageUrl.isNotEmpty
                    ? Flexible(
                        fit: FlexFit.loose,
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: orange,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : VideoWidget(
                        key: UniqueKey(),
                        postId: widget.postId,
                        videoUrl: widget.videoUrl,
                        sector: widget.sector ?? '',
                        cardId: widget.key.toString(),
                      ),
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      await _launchURL();
                      _recordAdClick();
                    },
                    child: ValueListenableBuilder(
                      valueListenable: viewed,
                      builder: (BuildContext context, dynamic value, _) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9.0, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.5,
                                    color: value ? orange : Colors.grey),
                              ),
                              color: value ? primaryColor : Colors.white),
                          child: (!widget.isDestacado)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ir al sitio',
                                      style: TextStyle(
                                          color: value
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: value
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color:
                                          value ? Colors.white : Colors.black,
                                    )
                                  ],
                                )
                              : SizedBox(),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10),
                  child: Wrap(
                    children: [
                      Text(widget.descripcion),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                child: IconButton(
                                  onPressed: () async =>
                                      await _navigateComments(context),
                                  icon: Icon(
                                    CustomIcons.comment,
                                    size: 18,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: commentNo,
                                builder:
                                    (BuildContext context, dynamic value, _) {
                                  return Text(
                                    value.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Row(
                            children: [
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    if (widget.isDestacado) {
                                      _toggleLikeDestacado(context);
                                    } else {
                                      _toggleLike(context);
                                    }
                                  },
                                  icon: ValueListenableBuilder(
                                    valueListenable: isLiked,
                                    builder: (BuildContext context,
                                        dynamic value, _) {
                                      return value ?? false
                                          ? Icon(
                                              Icons.favorite,
                                              color: primaryColor,
                                              size: 23,
                                            )
                                          : Icon(
                                              Icons.favorite_outline,
                                              color: primaryColor,
                                              size: 23,
                                            );
                                    },
                                  ),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: likesCount,
                                builder:
                                    (BuildContext context, dynamic value, _) {
                                  return Text(
                                    value.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (!widget.isDestacado)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(CustomIcons.share, size: 21),
                                color: primaryColor,
                                onPressed: () async {
                                  /// Keep this line, maybe it could be necessary
                                  // if (widget.imageUrl != null) {
                                  //   final cache = DefaultCacheManager();
                                  //   await cache.getSingleFile(widget.imageUrl);

                                  //   // customShare(context);
                                  // }
                                  SocialShare.shareOptions(
                                          "He encontrado este anuncio que puede interesarte: ${widget.videoUrl ?? widget.link}")
                                      .then((data) {});
                                }),
                            IconButton(
                              onPressed: () {
                                _toggleSave(context);
                              },
                              icon: ValueListenableBuilder(
                                valueListenable: isSaved,
                                builder:
                                    (BuildContext context, dynamic value, _) {
                                  return value ?? false
                                      ? Icon(Icons.bookmark)
                                      : Icon(Icons.bookmark_border);
                                },
                              ),
                              color: Color(0xFFFF0094),
                            )
                          ],
                        ),
                      if (widget.isDestacado)
                        SizedBox(
                          height: 10,
                        )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
