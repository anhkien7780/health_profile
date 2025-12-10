import 'package:health_profile/models/entities/appointment.dart';
import 'package:health_profile/models/entities/doctor.dart';
import 'package:health_profile/models/entities/hospital.dart';
import 'package:health_profile/models/entities/schedule_slot.dart';

abstract class AppointmentRepository {
  Future<List<Hospital>> getHospitals();

  Future<List<Doctor>> getDoctors();

  Future<List<ScheduleSlot>> getScheduleSlots();

  Future<void> bookAppointment(Appointment appointment);
}

class AppointmentRepositoryImpl extends AppointmentRepository {
  @override
  Future<List<Hospital>> getHospitals() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Hospital(
        id: 1,
        name: "Bệnh viện Bạch Mai",
        address: "78 Giải Phóng, Hà Nội",
        phone: "02438693731",
        email: "contact@bachmai.gov.vn",
        type: "PUBLIC",
        imageUrl: "https://picsum.photos/id/48/200/200",
      ),
      Hospital(
        id: 2,
        name: "Bệnh viện Việt Đức",
        address: "40 Tràng Thi, Hà Nội",
        phone: "02438253531",
        email: "contact@vietduc.gov.vn",
        type: "PUBLIC",
        imageUrl: "https://picsum.photos/id/59/200/200",
      ),
      Hospital(
        id: 3,
        name: "Bệnh viện Đại học Y Hà Nội",
        address: "1 Tôn Thất Tùng, Hà Nội",
        phone: "02435747788",
        email: "contact@hmu.edu.vn",
        type: "PUBLIC",
        imageUrl: "https://picsum.photos/id/88/200/200",
      ),
      Hospital(
        id: 4,
        name: "Bệnh viện Nhi Trung ương",
        address: "18/879 La Thành, Hà Nội",
        phone: "02462738532",
        email: "contact@nhi.org.vn",
        type: "PUBLIC",
        imageUrl: "https://picsum.photos/id/111/200/200",
      ),
    ];
  }

  @override
  Future<List<Doctor>> getDoctors() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Doctor(
        id: 1,
        fullName: "Bác Sĩ Nguyễn Văn B",
        specialty: "Tim mạch",
        hospitalId: 1,
        departmentId: 1,
        experienceYears: 10,
        consultationFee: 500000,
        avatarUrl: "https://i.pravatar.cc/150?img=11",
      ),
      Doctor(
        id: 2,
        fullName: "Bác Sĩ Trần Thị C",
        specialty: "Nhi khoa",
        hospitalId: 2,
        departmentId: 2,
        experienceYears: 8,
        consultationFee: 400000,
        avatarUrl: "https://i.pravatar.cc/150?img=5",
      ),
      Doctor(
        id: 3,
        fullName: "Bác Sĩ Lê Văn D",
        specialty: "Chấn thương chỉnh hình",
        hospitalId: 3,
        departmentId: 3,
        experienceYears: 12,
        consultationFee: 600000,
        avatarUrl: "https://i.pravatar.cc/150?img=3",
      ),
      Doctor(
        id: 4,
        fullName: "Bác Sĩ Phạm Thị E",
        specialty: "Da liễu",
        hospitalId: 1,
        departmentId: 4,
        experienceYears: 5,
        consultationFee: 300000,
        avatarUrl: "https://i.pravatar.cc/150?img=9",
      ),
      Doctor(
        id: 5,
        fullName: "Bác Sĩ Hoàng Văn F",
        specialty: "Thần kinh",
        hospitalId: 2,
        departmentId: 5,
        experienceYears: 15,
        consultationFee: 700000,
        avatarUrl: "https://i.pravatar.cc/150?img=12",
      ),
    ];
  }

  @override
  Future<List<ScheduleSlot>> getScheduleSlots() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ScheduleSlot(
        id: 1,
        roomName: "Phòng khám dị ứng (P.312 Nhà C)",
        slots: ["07:00", "07:15", "07:30", "08:00", "13:00"],
      ),
      ScheduleSlot(
        id: 2,
        roomName: "Phòng khám dị ứng (P.412 Nhà C)",
        slots: ["08:00", "13:00", "13:30", "14:00", "14:30"],
      ),
    ];
  }

  @override
  Future<void> bookAppointment(Appointment appointment) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate success
    return;
  }
}
