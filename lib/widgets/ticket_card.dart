import 'dart:ui';

import 'package:Eventbrite/screens/user/ticket_details_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../providers/tickets/ticket.dart';

class TicketCard extends StatelessWidget {
  Ticket ticket;
  bool old = false;
  TicketCard(this.ticket, this.old, {super.key});

  Color col = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => TicketsDetailsScreen(),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.01,
            top: MediaQuery.of(context).size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipPath(
                        clipper: CardTicketClipper(),
                        child: Container(
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.9 * 0.6,
                          color: col,
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.9 * 0.5,
                              height: MediaQuery.of(context).size.height *
                                  0.15 *
                                  0.75,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          DateFormat.MMM().format(ticket.date),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          DateFormat.d().format(ticket.date),
                                          style: GoogleFonts.roboto(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          DateFormat.y().format(ticket.date),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9 *
                                                0.5 *
                                                0.6,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          ticket.title,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9 *
                                                0.5 *
                                                0.6,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          ' ${DateFormat.E().format(ticket.date)} at ${DateFormat.jm().format(ticket.date)}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    CustomPaint(
                      painter: CardTicketBorder(),
                      size: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? Size(MediaQuery.of(context).size.width * 0.6 * 0.9,
                              MediaQuery.of(context).size.height * 0.3)
                          : Size(MediaQuery.of(context).size.width * 0.6 * 0.9,
                              MediaQuery.of(context).size.height * 0.15),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipPath(
                        clipper: ImageTicketClipper(),
                        child: Container(
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: col,
                          child: Container(
                            foregroundDecoration: old
                                ? const BoxDecoration(
                                    color: Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  )
                                : null,
                            child: FadeInImage(
                              image: ticket.eventImgUrl.isEmpty
                                  ? AssetImage(
                                          'assets/images/no_image_found.png')
                                      as ImageProvider
                                  : NetworkImage(
                                      ticket.eventImgUrl,
                                    ),
                              placeholder: AssetImage(
                                  "assets/images/no_image_found.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                    'assets/images/no_image_found.png',
                                    fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    CustomPaint(
                      painter: ImageTicketBorder(),
                      size: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? Size(MediaQuery.of(context).size.width * 0.4,
                              MediaQuery.of(context).size.height * 0.3)
                          : Size(MediaQuery.of(context).size.width * 0.4,
                              MediaQuery.of(context).size.height * 0.15),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//concave shape in the middle

class ImageTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path
      ..moveTo(0, size.height * 0.05)
      ..lineTo(0, size.height * 0.95)
      ..quadraticBezierTo(
          size.width * 0.05, size.height * 0.95, size.width * 0.05, size.height)
      ..lineTo(size.width * 0.95, size.height)
      ..arcToPoint(Offset(size.width, size.height * 0.95),
          radius: Radius.circular(size.width * 0.05), clockwise: false)
      ..lineTo(size.width, size.height * 0.05)
      ..arcToPoint(Offset(size.width * 0.95, 0),
          radius: Radius.circular(size.width * 0.05), clockwise: false)
      ..lineTo(size.width * 0.05, 0)
      ..quadraticBezierTo(
          size.width * 0.05, size.height * 0.05, 0, size.height * 0.05)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}

class CardTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path
      ..moveTo(size.width, size.height * 0.1)
      ..lineTo(size.width, size.height * 0.95)
      ..quadraticBezierTo(
          size.width * 0.97, size.height * 0.95, size.width * 0.97, size.height)
      ..lineTo(size.width * 0.05, size.height)
      ..arcToPoint(Offset(0, size.height * 0.95),
          radius: Radius.circular(size.width * 0.05), clockwise: true)
      ..lineTo(0, size.height * 0.05)
      ..arcToPoint(Offset(size.width * 0.05, 0),
          radius: Radius.circular(size.width * 0.05), clockwise: true)
      ..lineTo(size.width * 0.97, 0)
      ..quadraticBezierTo(
          size.width * 0.97, size.height * 0.05, size.width, size.height * 0.05)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}

class ImageTicketBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path
      ..moveTo(0, size.height * 0.95)
      ..quadraticBezierTo(
          size.width * 0.05, size.height * 0.95, size.width * 0.05, size.height)
      ..lineTo(size.width * 0.95, size.height)
      ..arcToPoint(Offset(size.width, size.height * 0.95),
          radius: Radius.circular(size.width * 0.05), clockwise: false)
      ..lineTo(size.width, size.height * 0.05)
      ..arcToPoint(Offset(size.width * 0.95, 0),
          radius: Radius.circular(size.width * 0.05), clockwise: false)
      ..lineTo(size.width * 0.05, 0)
      ..quadraticBezierTo(
          size.width * 0.05, size.height * 0.05, 0, size.height * 0.05)
      ..moveTo(0, size.height * 0.05)
      ..lineTo(0, size.height * 0.15)
      ..moveTo(0, size.height * 0.2)
      ..lineTo(0, size.height * 0.25)
      ..moveTo(0, size.height * 0.3)
      ..lineTo(0, size.height * 0.35)
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height * 0.45)
      ..moveTo(0, size.height * 0.5)
      ..lineTo(0, size.height * 0.55)
      ..moveTo(0, size.height * 0.6)
      ..lineTo(0, size.height * 0.65)
      ..moveTo(0, size.height * 0.7)
      ..lineTo(0, size.height * 0.75)
      ..moveTo(0, size.height * 0.8)
      ..lineTo(0, size.height * 0.85)
      ..moveTo(0, size.height * 0.95)
      ..close();

    Paint paint = Paint();

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Color.fromARGB(255, 187, 187, 187);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ImageTicketBorder oldDelegate) {
    return false;
  }
}

class CardTicketBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path
      ..moveTo(size.width, size.height * 0.95)
      ..quadraticBezierTo(
          size.width * 0.97, size.height * 0.95, size.width * 0.97, size.height)
      ..lineTo(size.width * 0.05, size.height)
      ..arcToPoint(Offset(0, size.height * 0.95),
          radius: Radius.circular(size.width * 0.05), clockwise: true)
      ..lineTo(0, size.height * 0.05)
      ..arcToPoint(Offset(size.width * 0.05, 0),
          radius: Radius.circular(size.width * 0.05), clockwise: true)
      ..lineTo(size.width * 0.97, 0)
      ..quadraticBezierTo(
          size.width * 0.97, size.height * 0.05, size.width, size.height * 0.05)
      ..moveTo(0, size.height * 0.1)
      ..lineTo(0, size.height * 0.15)
      ..moveTo(0, size.height * 0.2)
      ..lineTo(0, size.height * 0.25)
      ..moveTo(0, size.height * 0.3)
      ..lineTo(0, size.height * 0.35)
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height * 0.45)
      ..moveTo(0, size.height * 0.5)
      ..lineTo(0, size.height * 0.55)
      ..moveTo(0, size.height * 0.6)
      ..lineTo(0, size.height * 0.65)
      ..moveTo(0, size.height * 0.7)
      ..lineTo(0, size.height * 0.75)
      ..moveTo(0, size.height * 0.8)
      ..lineTo(0, size.height * 0.85)
      ..moveTo(0, size.height * 0.9)
      ..close();

    Paint paint = Paint();

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Color.fromARGB(255, 187, 187, 187);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CardTicketBorder oldDelegate) {
    return false;
  }
}

class ArcClipperR extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //Arranca desde la punta topLeft
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * .0, size.height);
    //concave deepness, side (middle curved or at the sides), side deepness, curve start point
    path.quadraticBezierTo(size.width * 0.2, size.height, 0, size.height - 50);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
