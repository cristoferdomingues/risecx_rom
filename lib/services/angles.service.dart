import 'dart:math';

enum JOINTS { TRUNK_LEAN, KNEE, ELBOW, HIPS, DORSI }

class AnglesService {
  getAngle(Map<String, List<double>> poses, JOINTS joints) {
    try {
      Map<String, Map<String, double>> knees = {
        'left': {'x': poses['leftKnee']![0], 'y': poses['leftKnee']![1]},
        'right': {'x': poses['rightKnee']![0], 'y': poses['rightKnee']![1]}
      };

      Map<String, Map<String, double>> hips = {
        'left': {'x': poses['leftHip']![0], 'y': poses['leftHip']![1]},
        'right': {'x': poses['rightHip']![0], 'y': poses['rightHip']![1]}
      };

      Map<String, Map<String, double>> ankles = {
        'left': {'x': poses['leftAnkle']![0], 'y': poses['leftAnkle']![1]},
        'right': {'x': poses['rightAnkle']![0], 'y': poses['rightAnkle']![1]}
      };

      Map<String, Map<String, double>> shoulders = {
        'left': {
          'x': poses['leftShoulder']![0],
          'y': poses['leftShoulder']![1]
        },
        'right': {
          'x': poses['rightShoulder']![0],
          'y': poses['rightShoulder']![1]
        }
      };

      Map<String, Map<String, double>> elbows = {
        'left': {'x': poses['leftElbow']![0], 'y': poses['leftElbow']![1]},
        'right': {'x': poses['rightElbow']![0], 'y': poses['rightElbow']![1]}
      };
      Map<String, Map<String, double>> wrists = {
        'left': {'x': poses['leftWrist']![0], 'y': poses['leftWrist']![1]},
        'right': {'x': poses['rightWrist']![0], 'y': poses['rightWrist']![1]}
      };

      if (joints.index == JOINTS.KNEE.index) {
        return _getKneeFlexion(ankles, knees, hips);
      }
      if (joints.index == JOINTS.HIPS.index) {
        return _getHipFlexion(knees, hips, shoulders);
      }
      if (joints.index == JOINTS.DORSI.index) {
        return _getDorsiFlexion(knees, hips, ankles);
      }
      if (joints.index == JOINTS.TRUNK_LEAN.index) {
        return _getTrunkLean(knees, hips, shoulders);
      }
    } catch (e) {
      throw e;
    }
  }

  Map<String, double> _getKneeFlexion(ankles, knees, hips) {
    Function getResultBySide = (String side) =>
        (atan2(ankles[side]['y'] - knees[side]['y'],
                ankles[side]['x'] - knees[side]['x']) -
            atan2(hips[side]['y'] - knees[side]['y'],
                hips[side]['x'] - knees[side]['x'])) *
        (180 / pi);

    try {
      return {
        'left': getResultBySide('left'),
        'right': getResultBySide('right')
      };
    } catch (e) {
      throw e;
    }
  }

  Map<String, double> _getHipFlexion(knees, hips, shoulders) {
    Function getResultBySide = (String side) =>
        360 -
        (atan2(knees[side]['y'] - hips[side]['y'],
                    knees[side]['x'] - hips[side]['x']) -
                atan2(shoulders[side]['y'] - hips[side]['y'],
                    shoulders[side]['x'] - hips[side]['x'])) *
            (180 / pi);
    try {
      return {
        'left': getResultBySide('left'),
        'right': getResultBySide('right')
      };
    } catch (e) {
      throw e;
    }
  }

  Map<String, double> _getDorsiFlexion(knees, hips, ankles) {
    Function getResultBySide = (String side) =>
        360 -
        (atan2(ankles[side]['y'] - ankles[side]['y'],
                    knees[side]['x'] - ankles[side]['x']) -
                atan2(knees[side]['y'] - ankles[side]['y'],
                    knees[side]['x'] - ankles[side]['x'])) *
            (180 / pi);
    try {
      return {
        'left': getResultBySide('left'),
        'right': getResultBySide('right')
      };
    } catch (e) {
      throw e;
    }
  }

  Map<String, double> _getTrunkLean(knees, hips, shoulders) {
    Function getResultBySide = (String side) =>
        360 -
        (atan2(hips[side]['y'] - hips[side]['y'],
                    shoulders[side]['x'] - hips[side]['x']) -
                atan2(shoulders[side]['y'] - hips[side]['y'],
                    shoulders[side]['x'] - hips[side]['x'])) *
            (180 / pi);
    try {
      return {
        'left': getResultBySide('left'),
        'right': getResultBySide('right')
      };
    } catch (e) {
      throw e;
    }
  }
}
