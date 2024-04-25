// ignore_for_file: depend_on_referenced_packages

import 'package:chatapp/entity/user_entity.dart';
import 'package:floor/floor.dart';


@dao
abstract class UtilisateurDao {
  @Query("SELECT * FROM utilisateur")
  Future<List<Utilisateur>> findAllUsers();

  @Query("SELECT * FROM utilisateur WHERE id= :id")
  Future<Utilisateur?> fintUser(int id);

  @insert
  Future<void> insertUtilisateur(Utilisateur user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateUtilisateur(Utilisateur user);

  @delete
  Future<void> deleteUtilisateur(Utilisateur user);
}