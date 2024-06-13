import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/category_provider.dart';
import '../models/category.dart';
import 'package:uuid/uuid.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('Nenhuma imagem selecionada.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Categoria'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome da Categoria'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome da categoria';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text('Câmera'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text('Galeria'),
                  ),
                ],
              ),
              _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      height: 200,
                    )
                  : Container(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _imageFile != null) {
                    final newCategory = Category(
                      id: Uuid().v4(),
                      name: _nameController.text,
                      imageUrl: _imageFile!.path,
                    );
                    Provider.of<CategoryProvider>(context, listen: false).addCategory(newCategory as String);
                    Navigator.pop(context);
                  } else if (_imageFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, adicione uma imagem da categoria.')),
                    );
                  }
                },
                child: Text('Adicionar Categoria'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
