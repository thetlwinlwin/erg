import 'package:chopper/chopper.dart';
import 'package:erg/api/roof/roof_api.dart';
import 'package:erg/features/shared/models/roof/roof_model.dart';
import 'package:erg/features/shared/widget/basic_info_utils.dart';
import 'package:erg/managers/customer_manager.dart';
import 'package:erg/managers/listener_manager.dart';
import 'package:erg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/widget/table_rows.dart';
import '../../shared/widget/error_snack_bar.dart';
import 'roof_custom_text_form.dart';

class RoofOrderScreen extends StatefulWidget {
  static Page page({LocalKey? key}) => MaterialPage(
        child: const RoofOrderScreen(),
        key: key,
      );
  const RoofOrderScreen({Key? key}) : super(key: key);

  @override
  State<RoofOrderScreen> createState() => _RoofOrderScreenState();
}

class _RoofOrderScreenState extends State<RoofOrderScreen> {
  late TextEditingController _colorController;
  late TextEditingController _countryController;
  late TextEditingController _lengthController;
  late TextEditingController _totalSheetsController;
  late TextEditingController _thicknessController;
  late TextEditingController _notesController;
  late FocusNode _colorNode;
  int _currentStep = 0;
  String _productionStage = ProudctStageValues.pending;
  final DateTime _currentDatetime = DateTime.now();
  late DateTime _pickupDateTime;

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  @override
  void initState() {
    initingControllers();
    _colorNode = FocusNode();
    super.initState();
  }

  void initingControllers() {
    _colorController = TextEditingController();
    _countryController = TextEditingController();
    _totalSheetsController = TextEditingController();
    _lengthController = TextEditingController();
    _thicknessController = TextEditingController();
    _notesController = TextEditingController();
    _pickupDateTime = _currentDatetime;

    _lengthController.addListener(() => setState(() {}));
    _thicknessController.addListener(() => setState(() {}));
    _countryController.addListener(() => setState(() {}));
    _totalSheetsController.addListener(() => setState(() {}));
    _colorController.addListener(() => setState(() {}));
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _thicknessController.dispose();
    _colorController.dispose();
    _notesController.dispose();
    _totalSheetsController.dispose();
    _countryController.dispose();
    _colorNode.dispose();
    super.dispose();
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
          children: const [Text('Roof'), Text('info')],
        ),
        content: Form(
          key: formKeys[1],
          child: Column(children: [
            ...roofOrderTextFields(
              colorNode: _colorNode,
              colorController: _colorController,
              countryController: _countryController,
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
            TableRow(
              children: [
                const Text('အရောင်'),
                Text(_colorController.text.toLowerCase()),
              ],
            ),
            // ds depth
            TableRow(
              children: [
                const Text('Coil ထုပ်လုပ်သည့်နိုင်ငံ'),
                Text(_countryController.text.toLowerCase()),
              ],
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

  void _submitOrderHandler() async {
    final _newOrder = RoofDataCreateModel(
      customerId:
          Provider.of<CustomerManager>(context, listen: false).customerId!,
      detail: RoofDetailModel(
        color: _colorController.text.toLowerCase(),
        manufacturer: _countryController.text.toLowerCase(),
        productionStage: _productionStage,
        notes: _notesController.text,
        lengthPerSheet: _parseToDouble(_lengthController.text),
        totalSheets: int.parse(_totalSheetsController.text),
        thickness: _parseToDouble(_thicknessController.text),
        pickupDate: _pickupDateTime.toUtc(),
      ),
    );

    Response result = await RoofOrderService.create(
            manager: Provider.of<ListenerManager>(context, listen: false))
        .createRoofOrder(newRoofOrder: _newOrder);

    if (!result.isSuccessful) {
      errorSnackBar(result.error.toString(), context);
    }
    if (result.isSuccessful) {
      context.goNamed('Home');
    }
  }

  void _productionStageHandler(String? val) {
    if (val != null) {
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
