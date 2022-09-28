import 'package:chopper/chopper.dart';
import 'package:erg/api/c_channel/c_channel_api.dart';
import 'package:erg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../managers/customer_manager.dart';
import '../../../managers/listener_manager.dart';
import '../../shared/models/c_channel/c_channel_model.dart';
import '../../shared/widget/basic_info_utils.dart';
import '../../shared/widget/error_snack_bar.dart';
import '../../shared/widget/table_rows.dart';
import 'cchannel_custom_text_form.dart';
import 'package:http_parser/http_parser.dart';

import 'cchannel_table_rows.dart';

class CChannelOrderScreen extends StatefulWidget {
  static Page page({LocalKey? key}) => MaterialPage(
        child: const CChannelOrderScreen(),
        key: key,
      );
  const CChannelOrderScreen({Key? key}) : super(key: key);

  @override
  State<CChannelOrderScreen> createState() => _CChannelOrderScreenState();
}

class _CChannelOrderScreenState extends State<CChannelOrderScreen> {
  late TextEditingController _heightController;
  late TextEditingController _widthController;
  late TextEditingController _gradeController;
  late TextEditingController _lengthController;
  late TextEditingController _thicknessController;
  late TextEditingController _totalSheetsController;
  late TextEditingController _notesController;
  final ImagePicker _picker = ImagePicker();
  late FocusNode _widthNode;
  late FocusNode _gradeNode;
  int _currentStep = 0;
  String _productionStage = ProudctStageValues.pending;
  final DateTime _currentDatetime = DateTime.now();
  late DateTime _pickupDateTime;
  XFile? _photo;

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  @override
  void initState() {
    _widthNode = FocusNode();
    _gradeNode = FocusNode();
    initingControllers();
    super.initState();
  }

  void initingControllers() {
    _heightController = TextEditingController();
    _widthController = TextEditingController();
    _gradeController = TextEditingController();
    _totalSheetsController = TextEditingController();
    _lengthController = TextEditingController();
    _thicknessController = TextEditingController();
    _notesController = TextEditingController();
    _pickupDateTime = _currentDatetime;

    _heightController.addListener(() => setState(() {}));
    _widthController.addListener(() => setState(() {}));
    _gradeController.addListener(() => setState(() {}));
    _lengthController.addListener(() => setState(() {}));
    _thicknessController.addListener(() => setState(() {}));
    _totalSheetsController.addListener(() => setState(() {}));
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _heightController.dispose();
    _widthController.dispose();
    _gradeController.dispose();
    _lengthController.dispose();
    _thicknessController.dispose();
    _totalSheetsController.dispose();
    _notesController.dispose();
    _widthNode.dispose();
    _gradeNode.dispose();
    super.dispose();
  }

  Future _getImage() async {
    _photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    // TODO : This setState is to change the table row of "HOLES" in last step.

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          controlsBuilder:
              (BuildContext context, ControlsDetails controlsBuilder) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                            controlsBuilder.stepIndex != getSteps().length - 1
                                ? const Text('Next')
                                : const Text('Done'),
                      ),
                      onPressed: controlsBuilder.onStepContinue,
                    ),
                  ),
                ),
                if (_currentStep != 0)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 10),
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Back'),
                        ),
                        onPressed: controlsBuilder.onStepCancel,
                      ),
                    ),
                  ),
              ],
            );
          },
          onStepContinue: () {
            final isLastStep = _currentStep == getSteps().length - 1;
            if (isLastStep) {
              _submitOrderHandler();
            } else {
              if (formKeys[_currentStep].currentState!.validate()) {
                formKeys[_currentStep].currentState!.save();
                setState(() {
                  _currentStep += 1;
                });
              }
            }
          },
          onStepTapped: (int? step) => setState(() {
            _currentStep = step!;
          }),
          onStepCancel: _currentStep == 0
              ? null
              : () => setState(() {
                    _currentStep -= 1;
                  }),
          steps: getSteps(),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 0,
        title: Column(
          children: const [Text('Basic'), Text('info')],
        ),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: [
              ...basicInfoTextForm(
                notesController: _notesController,
                lengthController: _lengthController,
                thicknessController: _thicknessController,
                totalSheetsController: _totalSheetsController,
              ),
              kPaddingBox,
              ProductionStageRow(
                value: _productionStage,
                onChanged: _productionStageHandler,
              ),
              kPaddingBox,
              PickUpDateTimeRow(
                  pickupDateTime: _pickupDateTime,
                  datetimePickerHandler: _datetimePickerHandler),
            ],
          ),
        ),
      ),
      Step(
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 1,
        title: Column(
          children: const [Text('CC'), Text('info')],
        ),
        content: Form(
          key: formKeys[1],
          child: Column(children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/channel_image.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ...cChannelOrderTextFields(
              gradeController: _gradeController,
              gradeFocus: _gradeNode,
              heightController: _heightController,
              widthController: _widthController,
              widthFocus: _widthNode,
            ),
            Row(
              children: [
                const Expanded(
                    child: Text(
                  'Holes',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                )),
                IconButton(
                  onPressed: _getImage,
                  icon: const Icon(Icons.camera),
                ),
              ],
            ),
          ]),
        ),
      ),
      Step(
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        title: Column(
          children: const [Text('Final'), Text('check')],
        ),
        content: Table(
          children: [
            ...customerRows(context),
            ...basicInfoRows(
              notes: _notesController.text,
              stage: _productionStage,
              length: _lengthController.text,
              pickupDateTime: _pickupDateTime,
              thickness: _thicknessController.text,
              totalSheets: _totalSheetsController.text,
            ),
            ...cchannelRows(
              channelHeight: _heightController.text,
              channelWidth: _widthController.text,
              grade: _gradeController.text,
              holeDescription: _photo != null,
            ),
            //total sheets
          ],
        ),
      ),
    ];
  }

  double _parseToDouble(String val) {
    return double.parse(val);
  }

//Because MultipartFile is based on Stream, and a Stream can be read only once, you should create a new MultipartFile when the request is resubmitted.
//For retap.
  Future<http.MultipartFile?> _getFile() async {
    final mimeTypeData = lookupMimeType(_photo!.path)!.split('/');
    // this has to match "file" variable from backend.
    return await http.MultipartFile.fromPath('file', _photo!.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  }

  void _submitOrderHandler() async {
    final _newOrder = CChannelCreateModel(
      customerId:
          Provider.of<CustomerManager>(context, listen: false).customerId!,
      detail: CChannelDetailModel(
        notes: _notesController.text,
        productionStage: _productionStage,
        grade: _parseToDouble(_gradeController.text),
        channelHeight: _parseToDouble(_heightController.text),
        channelWidth: _parseToDouble(_widthController.text),
        lengthPerSheet: _parseToDouble(_lengthController.text),
        totalSheets: int.parse(_totalSheetsController.text),
        thickness: _parseToDouble(_thicknessController.text),
        pickupDate: _pickupDateTime.toUtc(),
      ),
    );

    Response result = await CChannelOrderService.create(
            manager: Provider.of<ListenerManager>(context, listen: false))
        .createOrder(
      file: await _getFile(),
      channelHeight: _newOrder.detail.channelHeight,
      channelWidth: _newOrder.detail.channelWidth,
      zincGrade: _newOrder.detail.grade.toInt(),
      customerId: _newOrder.customerId,
      sheetLength: _newOrder.detail.lengthPerSheet,
      noOfSheet: _newOrder.detail.totalSheets,
      thickness: _newOrder.detail.thickness,
      notes: _newOrder.detail.notes,
      stage: _newOrder.detail.productionStage,
      pickUpTime: _newOrder.detail.pickupDate,
    );

    if (!result.isSuccessful) {
      errorSnackBar(result.error.toString(), context);
    }
    if (result.isSuccessful) {
      context.goNamed('Home');
    }
  }

  void _productionStageHandler(String? val) {
    if (val is String) {
      setState(() {
        _productionStage = val;
      });
    }
  }

  void _datetimePickerHandler() async {
    final newDateTime = await customDatetimePicker(
      context: context,
      currentTime: _currentDatetime,
    );
    if (newDateTime != null) {
      setState(() {
        _pickupDateTime = newDateTime;
      });
    }
  }
}
