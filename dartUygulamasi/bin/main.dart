import 'package:postgres/postgres.dart';
import 'dart:io';

void main() async {
  var baglanti = PostgreSQLConnection(
    "localhost",
    5432,
    "sarkiUygulamasi",
    username: "postgres",
    password: "Seray1903.",
  );
  await baglanti.open();

  do {
    print('1- Kullanici Ara ');
    print('2- Kullanici Ekle ');
    print('3- Kullanici Düzenle ');
    print('4- Kullanici Sil ');
    //Seçim
    String? secim = stdin.readLineSync();

    switch (secim) {
      case "1":
        print("Aranacak Kullanicinin id'si: ");
        String? kullaniciId = stdin.readLineSync();

        print(
          await baglanti.query(
            "SELECT * FROM kullaniciAra($kullaniciId)",
          ),
        );

        break;

      case "2":
        print("İsim: ");
        String? ad = stdin.readLineSync();

        print("Soyisim: ");
        String? soyad = stdin.readLineSync();

        print("E-Mail: ");
        String? email = stdin.readLineSync();

        print("Doğum Tarihi (Yil şeklinde): ");
        String? dogumYili = stdin.readLineSync();

        print(
          await baglanti.query(
            "SELECT * FROM kullaniciEkle('$ad','$soyad','$email',$dogumYili)",
          ),
        );

        break;

      case "3":
        print('Güncellenecek Kullanici ID\'si: ');
        String? guncellenecekID = stdin.readLineSync();

        print("İsim: ");
        String? ad = stdin.readLineSync();

        print("Soyisim: ");
        String? soyad = stdin.readLineSync();

        print("E-Mail: ");
        String? email = stdin.readLineSync();

        print("Doğum Tarihi (Yil şeklinde): ");
        String? dogumYili = stdin.readLineSync();

        print(
          await baglanti.query(
            "SELECT * FROM kullaniciGuncelle($guncellenecekID,'$ad','$soyad','$email',$dogumYili)",
          ),
        );

        break;

      case "4":
        print("Silinecek Kullanicinin id'si: ");
        String? silinecekKullaniciId = stdin.readLineSync();

        print(
          await baglanti.query(
            "SELECT * FROM kullaniciSilme($silinecekKullaniciId)",
          ),
        );
        break;

      default:
        exit(0);
    }
  } while (true);

  exit(0);
}
