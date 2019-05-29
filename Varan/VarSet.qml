import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    GroupBox {
        id: groupBox3
        anchors.topMargin: 30
        anchors.fill: parent
        title: qsTr("Settings")

        Grid {
            id: grid
            spacing: 10
            rows: 7
            columns: 2
            anchors.fill: parent

            Label {
                id: label
                width: 100
                height: 30
                text: qsTr("Symbols len, us")
                verticalAlignment: Text.AlignTop
            }

            TextInput {
                id: tiSymbLen
                width: 100
                height: 30
                text: qsTr("1")
                inputMask: qsTr("999999; ")
                font.pixelSize: 12
            }




            Label {
                id: label2
                width: 100
                height: 30
                text: qsTr("Modulation")
                verticalAlignment: Text.AlignTop
            }



            ComboBox {
                id: comboBox
                width: 100
                height: 30
                model: [ "Nothing", "BPSK", "QPSK", "8-QAM", "16-QAM", "32-QAM", "64-QAM", "128-QAM", "256-QAM", "512-QAM", "FSK" ]

            }

            Label {
                id: label3
                width: 100
                height: 30
                text: qsTr("FSK Step, kHz")
                verticalAlignment: Text.AlignTop
            }

            TextInput {
                id: tiSymbLen1
                width: 100
                height: 30
                text: qsTr("1")
                font.pixelSize: 12
                inputMask: qsTr("999999; ")
            }

            Label {
                id: label4
                width: 100
                height: 30
                text: qsTr("Number of FSK")
                verticalAlignment: Text.AlignTop
            }

            TextInput {
                id: tiSymbLen2
                width: 100
                height: 30
                text: qsTr("1")
                font.pixelSize: 12
                inputMask: qsTr("999999; ")
            }

            CheckBox {
                id: checkBox
                text: qsTr("Random FSK")
                checkable: true
            }

            Button {
                id: button
                text: qsTr("Set")
                onClicked: {

                    var prt = [];
                    prt[0] = 0;
                    prt[1] = 0.03;
                    prt[2] = parseFloat(tiSymbLen.text)/1000000;
                    prt[3] = comboBox.currentIndex;
                    prt[4] = parseFloat(tiSymbLen1.text)*1000;
                    prt[5] = parseFloat(tiSymbLen2.text);
                    if(checkBox.checked) prt[6] = 1;
                    else prt[6] = 0;

                     window.qmlSignalPar(prt);

                }
            }
        }
    }


}



















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_height:400;anchors_width:400}
}
 ##^##*/
