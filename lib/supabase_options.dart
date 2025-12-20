import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: 'https://dwnitvqhsujibvuduglk.supabase.co',
    anonKey: 'sb_publishable_pcpyTSP5m9F-JceJ17lN1A_KGdJWPoC',
  );
}

SupabaseClient get supabase => Supabase.instance.client;
