import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtCharts 2.3
import QtDataVisualization 1.3
import QtGraphicalEffects 1.0



ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Varan")

    signal qmlSignal900(var snd900)
    signal qmlSignal1800(var snd1800)
    signal qmlSignalPar(var sndPar)


    SwipeView {
        id: swipeView
        anchors.fill: parent

        Item {
            GroupBox {
                id: groupBox
                anchors.topMargin: 30
                anchors.fill: parent
                title: qsTr("GSM 900")

                Rectangle {
                    id: rectangle
                    width: 200
                    color: "#ffffff"
                    anchors.topMargin: 0
                    transformOrigin: Item.Center
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.top: parent.top


                    CheckBox {
                        id: cbChanels
                        text: qsTr("Chanels")
                        onCheckedChanged: {
                            for(var i=0; i<174; i++) {
                                checkmodel.setProperty(i ,"value", checked);
                            }
                        }

                    }

                    ScrollView {

                        id: srlv
                        anchors.top: cbChanels.bottom
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.topMargin: 0


                        ListModel {
                            id: checkmodel
                            Component.onCompleted: {
                                for(var i = 0; i < 174; i++) {

                                    if (i < 125) {checkmodel.append({"name": "Chanel " + i + " (" + (890 + 0.2 * i + 45).toFixed(1) + " MHz)", "value": false}) }
                                    else {checkmodel.append({"name": "Chanel " + (i + 850) + " (" + (890 + 0.2 * (i + 850 - 1024) + 45).toFixed(1) + " MHz)", "value": false})}

                                }


                            }

                        }

                        ListView {
                            id: list900
                            anchors.topMargin: 30
                            anchors.fill: parent

                            objectName : "lvob"
                            model: checkmodel

                            delegate:

                                CheckDelegate {

                                text: name
                                width: parent.width

                                checked: value
                                onCheckStateChanged: {
                                    checkmodel.setProperty(index ,"value", checked);
                                }



                            }

                            ScrollBar.vertical: ScrollBar {

                                id: scrollBar
                                parent: list900.parent
                                anchors.top: list900.top
                                anchors.left: list900.right
                                anchors.bottom: list900.bottom
                            }


                        }




                    }

                    Button {
                        id: button
                        x: 100
                        y: 0
                        text: qsTr("Set")
                        onClicked: {

                            var snd = [];
                            var frq = 0;

                            ars.upperSeries.clear();

                            for(var i=0; i<174; i++) {

                                var ch = checkmodel.get(i);

                                if (i < 125) frq = 890 + 0.2 * i + 45;// - 952.5;
                                else frq = 890 + 0.2 * (i + 850 - 1024) + 45;// - 952.5;
                                //frq *= 1000;

                                if (ch.value === true) {


                                    if(i === 124) {

                                        ars.upperSeries.append(frq, 1);
                                        ars.upperSeries.append(frq + 0.2, 0);
                                    } else if(i === 125) {

                                        ars.upperSeries.append(frq - 0.2, 0);
                                        ars.upperSeries.append(frq, 1);
                                    } else {

                                        ars.upperSeries.append(frq, 1);
                                    }

                                    snd[i] = 1;
                                } else {

                                    ars.upperSeries.append(frq, 0);

                                    snd[i] = 0;
                                }

                                console.log(ch.value);

                            }


                            window.qmlSignal900(snd);
                        }
                    }


                }


                Rectangle {
                    id: rectangle1
                    x: 188
                    y: -31
                    color: "#ffffff"
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.topMargin: 30
                    anchors.left: rectangle.right
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.leftMargin: 36


                    ChartView {

                        //id: cv
                        title: "Spectrum"
                        anchors.fill: parent
                        antialiasing: true


                        // Define x-axis to be used with the series instead of default one
                        ValueAxis {

                            id: valueAxisX
                            min: 925
                            max: 960
                            //tickCount: 0.001
                            labelFormat: "%.00f"

                        }




                        AreaSeries {

                            id: ars
                            name: "FFT GSM 900"
                            axisX: valueAxisX
                            upperSeries: LineSeries {

                                //XYPoint { x: 925.2; y: 0 }


                            }

                        }





                    }

                }
            }
        }

        Item {
            GroupBox {
                id: groupBox1
                anchors.topMargin: 30
                anchors.fill: parent
                title: qsTr("GSM 1800")

                Rectangle {
                    id: rectangle3
                    width: 200
                    color: "#ffffff"
                    anchors.topMargin: 0
                    transformOrigin: Item.Center
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.top: parent.top


                    CheckBox {
                        id: cbChanels1
                        text: qsTr("Chanels")
                        onCheckedChanged: {
                            for(var i=0; i<274; i++) {
                                checkmodel1.setProperty(i ,"value", checked);
                            }
                        }

                    }

                    ScrollView {
                        id: srlv1
                        anchors.top: cbChanels1.bottom
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.topMargin: 0

                        ListModel {
                            id: checkmodel1
                            Component.onCompleted: {
                                for(var i = 0; i < 274; i++) {

                                    checkmodel1.append({"name": "Chanel " + (i + 612) + " (" + (1710.2 + 0.2 * (i + 612 - 512) + 95).toFixed(1) + " MHz)", "value": false});

                                }
                            }

                        }

                        ListView {
                            id: list1800
                            anchors.topMargin: 30
                            anchors.fill: parent

                            objectName : "lvob1"
                            model: checkmodel1

                            delegate:

                                CheckDelegate {

                                text: name
                                width: parent.width

                                checked: value
                                onCheckStateChanged: {
                                    checkmodel1.setProperty(index ,"value", checked);
                                }



                            }

                            ScrollBar.vertical: ScrollBar {

                                id: scrollBar1
                                parent: list1800.parent
                                anchors.top: list1800.top
                                anchors.left: list1800.right
                                anchors.bottom: list1800.bottom
                            }


                        }



                    }

                    Button {
                        id: button1
                        x: 100
                        y: 0
                        text: qsTr("Set")
                        onClicked: {

                            var snd = [];
                            var frq = 0;

                            ars1.upperSeries.clear();

                            for(var i=0; i<274; i++) {

                                var ch = checkmodel1.get(i);
                                frq = 1710.2 + 0.2 * (i + 612 - 512) + 95;

                                if (ch.value === true) {

                                    ars1.upperSeries.append(frq, 1);
                                    snd[i] = 1;
                                } else {


                                    ars1.upperSeries.append(frq, 0);
                                    snd[i] = 0;
                                }

                                console.log(ch.value);

                            }


                            window.qmlSignal1800(snd);
                        }
                    }


                }


                Rectangle {
                    id: rectangle4
                    x: 188
                    y: -31
                    width: 365
                    height: 374
                    color: "#ffffff"
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.topMargin: 30
                    anchors.left: rectangle3.right
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.leftMargin: 36

                    ChartView {

                        //id: cv
                        title: "Spectrum"
                        anchors.fill: parent
                        antialiasing: true


                        // Define x-axis to be used with the series instead of default one
                        ValueAxis {

                            id: valueAxisX1
                            min: 1825
                            max: 1880
                            //tickCount: 0.001
                            labelFormat: "%.00f"

                        }




                        AreaSeries {

                            id: ars1
                            name: "FFT GSM 1800"
                            axisX: valueAxisX1
                            upperSeries: LineSeries {

                                //XYPoint { x: 925.2; y: 0 }


                            }

                        }





                    }


                }




            }
        }

        Item {
            VarSet {
                id: varSet
                anchors.fill: parent
            }

        }


    }




}


















