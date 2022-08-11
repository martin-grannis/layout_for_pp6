import 'package:flutter/painting.dart';

class Presentation {
  String? presentationName;
  int? presentationHasTimeline;
  List<PresentationSlideGroups>? presentationSlideGroups;
  String? presentationCurrentLocation;
  //List<MySlideGroup>? presentationDecodedSlideGroups;
  int? slideCount;
  List<GroupSlides> LinearSlideArray = [];

  void setupLinearSlideArray() {
    String thisGroupName = "";
    String thisGroupColour = "";
    for (var i in presentationSlideGroups!) {
      if (i is PresentationSlideGroups) {
        thisGroupName = i.groupName ?? "";
        thisGroupColour = i.groupColor ?? "";

        for (var j in i.groupSlides!) {
          if (j is GroupSlides) {
            // this is the top of what we want
            j.groupName = thisGroupName;
            j.groupColour = thisGroupColour;
            LinearSlideArray.add(j);
            thisGroupColour = thisGroupName = '';
          }
        }
      }
    }
    // now we have th data in LinearArray we can ditch the original
    presentationSlideGroups = [];
  }

  Presentation(
      {this.presentationName,
      this.presentationHasTimeline,
      this.presentationSlideGroups,
      this.slideCount,
      this.presentationCurrentLocation,
      required this.LinearSlideArray});

  Presentation.fromJson(Map<String, dynamic> json) {
    presentationName = json['presentationName'];
    presentationHasTimeline = json['presentationHasTimeline'];
    if (json['presentationSlideGroups'] != null) {
      presentationSlideGroups = <PresentationSlideGroups>[];
      json['presentationSlideGroups'].forEach((v) {
        presentationSlideGroups!.add(new PresentationSlideGroups.fromJson(v));
      });
    }
    presentationCurrentLocation = json['presentationCurrentLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presentationName'] = this.presentationName;
    data['presentationHasTimeline'] = this.presentationHasTimeline;
    if (this.presentationSlideGroups != null) {
      data['presentationSlideGroups'] =
          this.presentationSlideGroups!.map((v) => v.toJson()).toList();
    }
    data['presentationCurrentLocation'] = this.presentationCurrentLocation;
    return data;
  }
}

// class MySlideGroup {
//   List<MySlide>? myDecodedSlides;
// }

// class MySlide {
//   late MemoryImage mySlideImage;
// }

class PresentationSlideGroups {
  String? groupName;
  String? groupColor;
  List<GroupSlides>? groupSlides;

  PresentationSlideGroups({this.groupName, this.groupColor, this.groupSlides});

  PresentationSlideGroups.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    groupColor = json['groupColor'];
    if (json['groupSlides'] != null) {
      groupSlides = <GroupSlides>[];
      json['groupSlides'].forEach((v) {
        groupSlides!.add(new GroupSlides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['groupColor'] = this.groupColor;
    if (this.groupSlides != null) {
      data['groupSlides'] = this.groupSlides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupSlides {
  // mb added for easy access
  String? groupName;
  String? groupColour;

  //
  String? slideIndex;
  int? slideAttachmentMask;
  String? slideLabel;
  String? slideColor;
  int? slideTransitionType;
  int? slideEnabled;
  String? slideText;
  String? slideNotes;
  String? slideImage;
  MemoryImage? SlideImageUsable;

  GroupSlides(
      {this.slideIndex,
      this.groupName,
      this.groupColour,
      this.slideAttachmentMask,
      this.slideLabel,
      this.slideColor,
      this.slideTransitionType,
      this.slideEnabled,
      this.slideText,
      this.slideNotes,
      this.slideImage,
      this.SlideImageUsable});

  GroupSlides.fromJson(Map<String, dynamic> json) {
    slideIndex = json['slideIndex'];
    slideAttachmentMask = json['slideAttachmentMask'];
    slideLabel = json['slideLabel'];
    //print(slideLabel);
    slideColor = json['slideColor'];
    slideTransitionType = json['slideTransitionType'];

// slideEnabled can be bool OR int
    if (json['slideEnabled'].runtimeType == bool) {
      slideEnabled = json['slideEnabled'] ? 1 : 0;
    } else {
      slideEnabled = json['slideEnabled'];
    }

    //slideEnabled = json['slideEnabled'] || json['slideEnabled'] ==1 ? 1 : 0;
    slideText = json['slideText'];
    slideNotes = json['slideNotes'];
    slideImage = json['slideImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slideIndex'] = this.slideIndex;
    data['slideAttachmentMask'] = this.slideAttachmentMask;
    data['slideLabel'] = this.slideLabel;
    data['slideColor'] = this.slideColor;
    data['slideTransitionType'] = this.slideTransitionType;
    data['slideEnabled'] = this.slideEnabled;
    data['slideText'] = this.slideText;
    data['slideNotes'] = this.slideNotes;
    data['slideImage'] = this.slideImage;
    return data;
  }
}

class PresentationCacheItem {
  final Presentation? presentation;
  final DateTime? date_time;
  PresentationCacheItem(this.presentation, this.date_time);
}

class CacheUpdate {
  String presentation_name;
  bool added;

  CacheUpdate(this.presentation_name, this.added);
}

class SinkMessage {
  String type;
  String payload;
  CacheUpdate cu;

  SinkMessage(
    this.type,
    this.payload,
    this.cu,
  );
}
