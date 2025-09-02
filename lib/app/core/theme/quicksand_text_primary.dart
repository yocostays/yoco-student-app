import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class QSPrimary16 extends StatelessWidget {
  final String Title;
  // Color? textcolor;
  // double? fontsize;
  // FontWeight? fontweight;
  final int? maxline;
  final bool? textalign;
  const QSPrimary16({
    super.key,
    required this.Title,
    // this.fontsize,
    // this.fontweight,
    // this.textcolor,
    this.maxline,
    this.textalign,
  });

  @override
  Widget build(BuildContext context) {
    return textalign == true
        ? Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            overflow: TextOverflow.ellipsis,
          );
  }
}

// font size 10

class QSPrimary10 extends StatelessWidget {
  final String Title;
  // Color? textcolor;
  // double? fontsize;
  // FontWeight? fontweight;
  final int? maxline;
  final bool? textalign;
  const QSPrimary10({
    super.key,
    required this.Title,
    // this.fontsize,
    // this.fontweight,
    // this.textcolor,
    this.maxline,
    this.textalign,
  });

  @override
  Widget build(BuildContext context) {
    return textalign == true
        ? Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            overflow: TextOverflow.ellipsis,
          );
  }
}

// fontsize 21
class QSPrimary21W700 extends StatelessWidget {
  final String Title;
  // Color? textcolor;
  // double? fontsize;
  // FontWeight? fontweight;
  final int? maxline;
  final bool? textalign;
  const QSPrimary21W700({
    super.key,
    required this.Title,
    // this.fontsize,
    // this.fontweight,
    // this.textcolor,
    this.maxline,
    this.textalign,
  });

  @override
  Widget build(BuildContext context) {
    return textalign == true
        ? Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            overflow: TextOverflow.ellipsis,
          );
  }
}

class QSPrimary15W700 extends StatelessWidget {
  final String Title;
  // Color? textcolor;
  // double? fontsize;
  // FontWeight? fontweight;
  final int? maxline;
  final bool? textalign;
  const QSPrimary15W700({
    super.key,
    required this.Title,
    // this.fontsize,
    // this.fontweight,
    // this.textcolor,
    this.maxline,
    this.textalign,
  });

  @override
  Widget build(BuildContext context) {
    return textalign == true
        ? Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            overflow: TextOverflow.ellipsis,
          );
  }
}

class QSPrimary14W600 extends StatelessWidget {
  final String Title;
  // Color? textcolor;
  // double? fontsize;
  // FontWeight? fontweight;
  final int? maxline;
  final bool? textalign;
  const QSPrimary14W600({
    super.key,
    required this.Title,
    // this.fontsize,
    // this.fontweight,
    // this.textcolor,
    this.maxline,
    this.textalign,
  });

  @override
  Widget build(BuildContext context) {
    return textalign == true
        ? Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            Title,
            // 'Rugby',
            style: GoogleFonts.getFont(
              'DM Sans',
              textStyle: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.textprimary,
              ),
            ),
            maxLines: maxline,
            overflow: TextOverflow.ellipsis,
          );
  }
}
