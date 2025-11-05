// return Card(
//   color: Colors.white,
//   elevation: 4,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(16),
//   ),
//   child: Padding(
//     padding: const EdgeInsets.all(14),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Nama pelapor
//         Text(
//           data?.namaPelapor ?? "Warga Tak Dikenal",
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 6),

//         // Jenis bencana
//         Text(
//           data?.jenisBencana ?? "Bencana tidak diketahui",
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 6),

//         // Deskripsi singkat
//         Text(
//           data?.deskripsi ??
//               "Belum ada keterangan lengkap dari pelapor mengenai kejadian ini.",
//           style: const TextStyle(
//             fontSize: 13,
//             color: Colors.black54,
//             height: 1.4,
//           ),
//         ),
//         const SizedBox(height: 10),

//         // Lokasi
//         Row(
//           children: [
//             const Icon(Icons.location_on, color: Colors.red, size: 16),
//             const SizedBox(width: 4),
//             Expanded(
//               child: Text(
//                 data?.lokasi ?? "Lokasi belum tercantum",
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// );
