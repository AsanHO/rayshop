import 'package:flutter/material.dart';

class NoticationBtn extends StatefulWidget {
  final String text;
  final bool showText;
  const NoticationBtn({
    super.key,
    required this.text,
    required this.showText,
  });

  @override
  State<NoticationBtn> createState() => _NoticationBtnState();
}

class _NoticationBtnState extends State<NoticationBtn> {
  bool isSwitchOn = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              widget.showText
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '오전 12:00 ~ 오전 5:00',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isSwitchOn
                  ? Text(
                      'ON',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    )
                  : Text(
                      'OFF',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
              Switch(
                value: isSwitchOn,
                onChanged: (bool value) {
                  setState(() {
                    isSwitchOn = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
