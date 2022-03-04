import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/components/input/input_field.dart';
import 'package:ez_xpert/screen/profile/profile_vm.dart';
import 'package:ez_xpert/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with BasePage<ProfileVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                const SizedBox(width: double.infinity, height: 10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      foregroundImage: provider.profilePick == null
                          ? NetworkImage(
                              provider.user?.photo ?? provider.imageUrl)
                          : FileImage(provider.profilePick!) as ImageProvider,
                      child: const CupertinoActivityIndicator(),
                      radius: 60,
                      backgroundColor: Colors.blue,
                    ),
                    Positioned(
                      bottom: 10,
                      right: -5,
                      child: InkWell(
                        onTap: () => provider.pickProfile(),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ProfileInput(
                  onsaved: (val) {
                    provider.user?.name = val;
                  },
                  hintText: "Name *",
                  // initialvalue: provider.user?.name ?? "jk",
                  controller: provider.name,
                  validator: Validators.basic,
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    provider.selectDob();
                  },
                  child: IgnorePointer(
                    child: ProfileInput(
                      onsaved: (val) {
                        provider.user?.dob = val;
                      },
                      controller: provider.dob,
                      sIcon: const Icon(Icons.calendar_today),
                      hintText: "Date of Birth *",
                      validator: Validators.basic,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ProfileInput(
                  onsaved: (val) {
                    provider.user?.father = val;
                  },
                  hintText: "Father/Husband *",
                  controller: provider.father,
                  validator: Validators.basic,
                ),
                const SizedBox(height: 10),
                ProfileInput(
                  onsaved: (val) {
                    provider.user?.email = val;
                  },
                  inputType: TextInputType.emailAddress,
                  hintText: "Email *",
                  controller: provider.email,
                  validator: Validators.email,
                ),
                const SizedBox(height: 10),
                ProfileInput(
                  onsaved: (val) {
                    provider.user?.mobile = val;
                  },
                  inputType: TextInputType.phone,
                  hintText: "Mobile *",
                  controller: provider.mobile,
                  validator: Validators.mobile,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: provider.pickDl,
                          child: Column(
                            children: [
                              const Text(
                                "Driving Licance",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: provider.dLPick == null
                                          ? NetworkImage(
                                              provider.user?.driversLicense ??
                                                  provider.dimage)
                                          : FileImage(provider.dLPick!)
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                // child: Text("data"),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: provider.pickTl,
                          child: Column(
                            children: [
                              const Text(
                                "Trade Licance",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: provider.tLPick == null
                                        ? NetworkImage(
                                            provider.user?.tradeLicense ??
                                                provider.dimage)
                                        : FileImage(provider.tLPick!)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: provider.pickSin,
                          child: Column(
                            children: [
                              const Text(
                                "SIN No.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: provider.sInPick == null
                                          ? NetworkImage(provider.user?.sinNo ??
                                              provider.dimage)
                                          : FileImage(provider.sInPick!)
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      provider.updaet();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProfileVM create() => ProfileVM();

  @override
  void initialise(BuildContext context) {}
}
