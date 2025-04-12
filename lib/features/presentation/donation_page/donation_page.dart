import 'package:capstone_pawfund_app/features/presentation/donation_page/bloc/donation_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();

  static const String DonatePageRoute = "/donation_page";
}

class _DonatePageState extends State<DonatePage> {
  DonationPageBloc donationPageBloc = DonationPageBloc();
  final NumberFormat _formatter = NumberFormat.decimalPattern('vi_VN');
  TextEditingController amountController = TextEditingController(text: "");
  TextEditingController nickNameController = TextEditingController(text: "");

  final List<Map<String, String>> data = [
    {
      "sender": "Nguyễn Phương Quang",
      "time": "2024-06-07 12:49:00",
      "amount": "+ 100.000",
      "content": "chăm sóc y tế",
    },
    {
      "sender": "Ẩn danh",
      "time": "2024-06-07 12:49:00",
      "amount": "+ 200.000",
      "content": "chăm sóc y tế",
    },
    {
      "sender": "Nguyễn Phương Quang",
      "time": "2024-06-07 12:49:00",
      "amount": "+ 300.000",
      "content": "chăm sóc y tế",
    },
    // Thêm các dòng khác nếu cần
  ];

  @override
  void initState() {
    super.initState();
    amountController.addListener(_formatInput);
  }

  @override
  void dispose() {
    amountController.removeListener(_formatInput);
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const Color mainOrangeColor = Color(0xFFF36439);

    return BlocConsumer<DonationPageBloc, DonationPageState>(
      bloc: donationPageBloc,
      listenWhen: (previous, current) => current is DonationPageActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ShowSnackBarActionState:
            final snackBarState = state as ShowSnackBarActionState;
            if (snackBarState.success == true) {
              ShowSnackBar.SuccessSnackBar(context, snackBarState.message);
            } else {
              ShowSnackBar.ErrorSnackBar(context, snackBarState.message);
            }
            break;
        }
      },
      builder: (context, state) {
        return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {}
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 1) header
                      _buildHeader(size),
                      const SizedBox(height: 20),

                      // 2) Phần nội dung bên dưới
                      _buildBody(size, mainOrangeColor),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget _buildHeader(Size size) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepOrangeAccent, Color(0xFFFFA726)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 50,
                child: IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "ủng hộ".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 50,
                child: IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(Size size, Color mainOrangeColor) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Animal Adoption Foundation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              _LogoShelter(mainOrangeColor),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Thông tin chi tiết",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: mainOrangeColor)),
                ],
              ),
              const SizedBox(height: 8),
              _shelterInfor(mainOrangeColor),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shelterInfor(Color mainOrangeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Số tài khoản:
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E5E5),
                  width: 1.5,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Số tài khoản:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "123456789",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Chủ tài khoản:
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Chủ tài khoản: :",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Animal Adoption Foundation".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Nội dung:
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Nội dung:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Họ tên cá nhân/ Tổ chức DGUH TT [nội dung] ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Ví dụ:
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Ví dụ:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Nguyen Phuong Quang DGUH TT y te",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Ví dụ ẩn danh:
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECEFF2),
                  width: 1.5,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Ví dụ ẩn danh:",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "AN DANH DGUH TT y te",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _LogoShelter(Color mainOrangeColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // căn thông tin top
      children: [
        // Vùng logo tròn
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.orange, // Màu viền cam
              width: 2,
            ),
          ),
          // Logo hoặc icon ở giữa
          child: Center(
            // Giả sử bạn có ảnh tại assets/images/dog_shield.png
            child: Image.asset(
              'assets/images/Logo_chua_xoa_nen.png',
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 10), // khoảng cách giữa logo và thông tin
        // Phần thông tin địa chỉ + điện thoại
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dòng địa chỉ
              const SizedBox(width: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: mainOrangeColor,
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      '1 Quang Trung, p.1, Q.Gò Vấp (50m)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),

              // Dòng số điện thoại
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 18,
                    color: mainOrangeColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '0900 100 100',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              // email
              const SizedBox(width: 5),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 18,
                    color: mainOrangeColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'quangnpse130190@gmail.com',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _DonateAmount(Color mainOrangeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text("Điền thông tin để ủng hộ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainOrangeColor)),
          const SizedBox(height: 20),
          const Text("Animal Adoption Foundation",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Số tiền (VNĐ)",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF36439)),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    hintText: "100.000",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Viền khi chưa focus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xFFF36439), width: 2), // Viền khi focus
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(
                              0xFFBD0D00)), // Bạn có thể thay màu lỗi tùy ý
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xFFBD0D00), width: 2),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập số tiền";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  "Biệt danh",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF36439)),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: nickNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    hintText: "ẩn danh",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Viền khi chưa focus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xFFF36439), width: 2), // Viền khi focus
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(
                              0xFFBD0D00)), // Bạn có thể thay màu lỗi tùy ý
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xFFBD0D00), width: 2),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập biệt danh";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      // Vòng tròn cam
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: mainOrangeColor, width: 2),
                        ),
                        child: Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainOrangeColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Ủng hộ ẩn danh",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Donate Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF36439),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Ủng hộ".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _formatInput() {
    final String value =
        amountController.text.replaceAll('.', '').replaceAll(',', '');
    if (value.isEmpty) return;

    final number = int.tryParse(value);
    if (number == null) return;

    final newText = _formatter.format(number);

    if (amountController.text != newText) {
      final cursorPos = newText.length;
      amountController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: cursorPos),
      );
    }
  }

  Widget _SupportStatementTable(Color mainOrangeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sao kê nhận tiền ủng hộ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: mainOrangeColor,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            columns: const [
              DataColumn(label: Text("Người chuyển")),
              DataColumn(label: Text("Thời gian")),
              DataColumn(label: Text("Số tiền")),
              DataColumn(label: Text("Nội dung")),
            ],
            rows: data.map((row) {
              return DataRow(cells: [
                DataCell(Text(row["sender"]!)),
                DataCell(Text(row["time"]!)),
                DataCell(Text(
                  row["amount"]!,
                  style: TextStyle(color: mainOrangeColor),
                )),
                DataCell(Text(row["content"]!)),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
