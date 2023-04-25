import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TicketCard extends StatefulWidget {
  const TicketCard({super.key});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  late ui.Image mask;
  late ui.Image image;
  List<bool> ready = [false, false];

  @override
  void initState() {
    super.initState();
    load('assets/images/TicketShape.png').then((i) {
      setState(() {
        mask = i;
        ready[0] = true;
      });
    });
    load('assets/images/yla.png').then((i) {
      setState(() {
        image = i;
        ready[1] = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: ((ready[0] == true) && ready[1] == true)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 166,
                    child: Stack(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/TicketShape2.png',
                            cacheHeight: 160,
                            cacheWidth:
                                (MediaQuery.of(context).size.width - 150)
                                    .toInt(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'MAR \n\n 21',
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Eventbrite',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 150,
                      height: 160,
                      child: CustomPaint(painter: ImagePainter(mask, image))),
                ],
              )
            : const LoadingSpinner(),
      ),
    );
  }

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}

class ImagePainter extends CustomPainter {
  ui.Image mask;
  ui.Image image;

  ImagePainter(this.mask, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null && mask != null) {
      var rect = Rect.fromLTRB(0, 0, 150, 150);
      Size outputSize = rect.size;
      Paint paint = new Paint();

      //Mask
      Size maskInputSize = Size(mask.width.toDouble(), mask.height.toDouble());
      final FittedSizes maskFittedSizes =
          applyBoxFit(BoxFit.fill, maskInputSize, outputSize);
      final Size maskSourceSize = maskFittedSizes.source;

      final Rect maskSourceRect = Alignment.center
          .inscribe(maskSourceSize, Offset.zero & maskInputSize);

      canvas.saveLayer(rect, paint);
      canvas.drawImageRect(mask, maskSourceRect, rect, paint);

      //Image
      Size inputSize = Size(image.width.toDouble(), image.height.toDouble());
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.cover, inputSize, outputSize);
      final Size sourceSize = fittedSizes.source;
      final Rect sourceRect =
          Alignment.center.inscribe(sourceSize, Offset.zero & inputSize);

      canvas.drawImageRect(
          image, sourceRect, rect, paint..blendMode = BlendMode.srcIn);

      // ui.ParagraphBuilder paragraph = ui.ParagraphBuilder(
      //   ui.ParagraphStyle(
      //     textAlign: TextAlign.center,
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //   ),
      // )
      //   ..pushStyle(ui.TextStyle(color: Colors.black))
      //   ..addText('Hello World');

      // canvas.drawParagraph(paragraph as ui.Paragraph, Offset.zero);
      //canvas.drawParagraph('asd' as ui.Paragraph, Offset.zero);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return mask != oldDelegate.mask || image != oldDelegate.image;
  }
}
