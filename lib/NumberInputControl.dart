import 'package:flutter/services.dart';

class NumLengthInputFormatter extends TextInputFormatter {
  int decimalLength;
  int integerLength;
  bool allowInputDecimal;

  NumLengthInputFormatter({this.decimalLength = 2, this.integerLength = 8}) : super();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (newValue.text.contains('.')) {
      int pointIndex = newValue.text.indexOf('.');
      String beforePoint = newValue.text.substring(0, pointIndex);
      print('$beforePoint');
      //小数点前内容大于integerLength
      if (beforePoint.length > integerLength) {
        print("A");
        value = oldValue.text;
        //newValue=oldValue;
        selectionIndex = oldValue.selection.end;
      } else
        //小数点前内容小于等于integerLength
          {
        String afterPoint = newValue.text.substring(pointIndex + 1, newValue.text.length);
        print('$afterPoint');
        if(afterPoint.contains('.'))
          {
            value = oldValue.text;
            //newValue=oldValue;
            selectionIndex = oldValue.selection.end;
            print(oldValue.text);
          }else if (afterPoint.length > decimalLength) {
          print("B");
          value = oldValue.text;
          //newValue=oldValue;
          selectionIndex = oldValue.selection.end;
          print(oldValue.text);
        }
      }
    } else {
      if (newValue.text.length > integerLength) {
        print("C");
        value = oldValue.text;
        //newValue=oldValue;
        selectionIndex = oldValue.selection.end;
      }
    }
    print("end:"+value);
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

// TextField(
// inputFormatters: [
// NumLengthInputFormatter(decimalLength: 8, integerLength: 2),
// ],
// ),