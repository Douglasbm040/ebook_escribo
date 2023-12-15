import 'package:ebook_escribo/modules/presenter/view/home_view.dart';
import 'package:flutter/material.dart';

class ButtonFavorite extends StatefulWidget {
  const ButtonFavorite({
    super.key,
    required this.isfavorite,
  });

  final bool isfavorite;

  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -1,
      child: InkWell(
        onTap: () {},
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[200],
          child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.amber,
              child: Icon(
                widget.isfavorite
                    ? Icons.bookmark_outlined
                    : Icons.bookmark_rounded,
                color: widget.isfavorite ? Colors.redAccent : Colors.white,
                size: 40,
              )),
        ),
      ),
    );
  }
}
