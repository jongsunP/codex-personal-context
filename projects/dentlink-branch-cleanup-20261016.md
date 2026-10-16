# Dentlink released branch cleanup - 2026-10-16

Recovery and deletion ledger. See [FE checkpoint](dentlink-fe.md) for current scope and status.

- Deleted: 4 local branches, 1 worktree, 154 personal remote branches. Server absence verified.
- Remote owner: jongsunP, verified by PR ownership and exact source HEAD.
- Web production: 951503d422e11620cb207d5f5890fa9a827d531a; Admin, Clinic and Lab deployment succeeded.
- Office: PR318 in main and v2.2.4.82/.83 tags; related files match main. Production v83 activation/install records do not establish the exact OTA source SHA.
- Lab: main bb619010, Production v13 / binary1.0.4 both OS active100%, user completion on 2026-10-12.
- Shared branches, tags, stashes, active/unreleased and uncertain work were preserved.

## Recovery

Each repository common Git directory contains verified bundles and manifests under
`codex-closeout/released-branch-cleanup-20261016/`. Web bundles are incremental and
require the preserved master history. App bundles are self-contained. Bundles are
local to this device; this ledger is Git-backed. Restoring a branch requires a new request.

## dentlink-client

### Deleted local items

| Branch | Previous SHA |
| --- | --- |
| `release/v1.88.0` | `94ffc8a9d6248c90ac6fc25f80573eb8400f7264` |

No worktrees removed.

### Deleted remote branches

| Branch | Previous SHA | Owner/source PR | Released PR |
| --- | --- | --- | --- |
| `DL-15223-qa` | `8c2eae5cf233ebcf04dd922bb0f65363a3fb28f1` | #4484 | #4484 |
| `codex/DL-15560-isv-step3-ready` | `fe8126b189752062bdbf8a44b117e530efad70f1` | #4411 | #4411 |
| `codex/DL-15560-isv-step3-revert` | `3e8a3c8b60765522099360787391cc10df5b9f87` | #4408 | #4408 |
| `codex/DL-15560-lab-shipment-photo` | `5dc084e7ca931a926b773ba157a98c86c7aafd16` | #4400 | #4400 |
| `codex/DL-15560-staging-ui-followup` | `092783fc69bc2fecc3521177015406c37424fac3` | #4405 | #4405 |
| `codex/DL-15560-turnaround-response-race` | `1bf5044718b04230de34a4f53f15349f4a9fe575` | #4391 | #4391 |
| `feat/dadan-qa-03.31-2` | `bf9b1c1265c86fc8d92b8a3bbbfc1867c4fded91` | #3879 | #3879 |
| `featur/DL-13246-qa-0518-18-22` | `14804f7a8c6b763db747d40458ef896c5ce8b0f5` | #4090 | #4090 |
| `feature/DL-10131-dadan-total` | `60101c914d8cb4b036a3f36299cd982f2c49f017` | #3847, #3845, #3839, #3837, #3836, #3835, #3832, #3831, #3830, #3829, #3824, #3823, #3819, #3818, #3816, #3815, #3814, #3813, #3812, #3811, #3810, #3809, #3808, #3806, #3804, #3781, #3771, #3728 | #3836 |
| `feature/DL-11810` | `406c5f5baaf389c41eaa4d777a97724288586e03` | #3476 | #3476 |
| `feature/DL-11852` | `096b3cf932412244e2892ded3739f333cd1c8ea3` | #3477 | #3477 |
| `feature/DL-12205` | `b1f3cf884c512e551f3209e830bc4d37ed5bcbc1` | #3556, #3554, #3553, #3552, #3549, #3547, #3546, #3545, #3543, #3542, #3537, #3536, #3528, #3525 | #3525 |
| `feature/DL-12205-1` | `d833ea65a4799388464f557937669547d6351a9e` | #3562 | #3562 |
| `feature/DL-12402` | `9b6a1834e3994418cd98b6da729f856cefb46c38` | #3517 | #3517 |
| `feature/DL-12639` | `dcf69809525d821a862ca45df69e8d446f3409d6` | #3569 | #3569 |
| `feature/DL-12647` | `8d1f9bca8b60be1081696eb95ee515826c480735` | #3565 | #3565 |
| `feature/DL-12673` | `9d151cdd2cf500572693d1c9da804ee1a0ea2814` | #3572 | #3572 |
| `feature/DL-13172` | `3cd3e574d8b3cdffe6a26238c48bd35bac2f665f` | #3729 | #3729 |
| `feature/DL-13174` | `4f46b5c9a0ab6ac90d3512da988dd9ffb46e6eb0` | #3766 | #3766 |
| `feature/DL-13246` | `7dda92862c1a4fd860ab66d0623103a5a2aac50a` | #4067, #4066, #4058, #4057, #4056, #4054, #4053, #4052, #4043 | #4066 |
| `feature/DL-13246-qa-0514` | `5b3cd6c89ac7f17b4b6c413c016a7476fbd761fb` | #4070 | #4070 |
| `feature/DL-13246-qa-0515-1` | `19304a551f2988041056c5bc71a31c8c70cec60f` | #4072 | #4072 |
| `feature/DL-13246-qa-0515-2` | `79d195ddd1eab737438a252e4348f09e953a798f` | #4074 | #4074 |
| `feature/DL-13246-qa-0515-3` | `2188d6dbc28447968ea0b247e7c778733cfdd76a` | #4077 | #4077 |
| `feature/DL-13246-qa-0518` | `331a22e2262454299fffa47d37b8527b5a8ef7d2` | #4085 | #4085 |
| `feature/DL-13246-qa-0518-2` | `1fcae64dbe2700affe38a969998824861226ff6e` | #4086 | #4086 |
| `feature/DL-13354` | `9939b28ddb5042f06ed7d598d1df7ff2d4ccf926` | #3730 | #3730 |
| `feature/DL-13396` | `b4daad52ab78f7fcc6dbc0bf3d5ac332f741b06e` | #3782 | #3782 |
| `feature/DL-13571` | `553a4fd46741aefb318a9ec41c955feb66543605` | #3787 | #3787 |
| `feature/DL-13599` | `399176519ff531a9d1d0f30ecf82265a9202db2e` | #3793 | #3793 |
| `feature/DL-13659` | `dfb33c3b2ba2fbc053b804eed3413cd7325a58ff` | #3817 | #3817 |
| `feature/DL-13801` | `d09bef74b10bd65d473a0823a737ef1c9ff6e260` | #3841 | #3841 |
| `feature/DL-13828` | `a148309acb3045b52e398099b2f022a897868a17` | #3848 | #3848 |
| `feature/DL-13844` | `10f728fed796948442ecfb3492c75270ca18a41d` | #3857, #3856, #3855, #3854, #3853, #3852 | #3853 |
| `feature/DL-13860` | `1ea602ef594b9f89a561d98aa66d40cf89ba47ad` | #3866, #3865, #3864 | #3866 |
| `feature/DL-13893` | `0607703bfeb6d393311c0e42faf71891eb229dc7` | #3873, #3872 | #3873 |
| `feature/DL-14025-dadan-after` | `553bed180cd6006670099ae422535dd1f520338b` | #3968, #3967 | #3968 |
| `feature/DL-14232` | `1ad100af8e1e37c11d209e30e6d0a89d63ddbf48` | #4399, #4371, #4353, #4352 | #4399 |
| `feature/DL-14232-release-qa` | `8920297f343d610f22eae035d3b4b6fd2e1bbcf5` | #4410 | #4410 |
| `feature/DL-14243` | `457dbc90739f6b385c9901999193152e0c3efb0c` | #3978 | #3978 |
| `feature/DL-14258` | `f144c7aa6d91a4c8f7a18486f20af24aeabc5fd3` | #3972 | #3972 |
| `feature/DL-14275` | `0a7e021e080149458c70258956cc77314be1b8f5` | #3975 | #3975 |
| `feature/DL-14386` | `78fb88600976c4be1841864095b8bd33482d30ca` | #3996 | #3996 |
| `feature/DL-14386-1` | `83465f69458ea2c9b2d6b5b6bd055abb9ffe5149` | #4001 | #4001 |
| `feature/DL-14455` | `f82a8bf692b1708db3f20c998bd193ce1f6bfe02` | #4018, #4011 | #4018 |
| `feature/DL-14510` | `bd14f22d0ea4325f45dee148c5f6d1d5e9c1dba3` | #4032 | #4032 |
| `feature/DL-14537` | `9397ccd8698cd7381fbf0ccbf2ec416a8fbe7d19` | #4033 | #4033 |
| `feature/DL-14597` | `a4e6f734b978cce77d3f904555da5e2a9b96e3e3` | #4042 | #4042 |
| `feature/DL-14598` | `b34be5e31088bd7281499998b64680762e906c0c` | #4121, #4112, #4111, #4108, #4107, #4103, #4101, #4100, #4097, #4096, #4094, #4093 | #4121 |
| `feature/DL-14752` | `8fedada321084901f2f2f00405ed791b795a8c82` | #4206, #4098 | #4206 |
| `feature/DL-14752-QA-5` | `7665af108e939c4eac6abd07e9d47ac9fa96becb` | #4248 | #4248 |
| `feature/DL-14752-qa-1` | `b53f4974bc769da238db4949be5117e378d1310d` | #4210 | #4210 |
| `feature/DL-14752-qa-2` | `bac107046e74291d35515186bb03f624739cf71c` | #4213 | #4213 |
| `feature/DL-14752-qa-3` | `f26bc92f052844ac3e98549a4d83e730c0a3a7cf` | #4232 | #4232 |
| `feature/DL-14752-qa-4` | `54a9b02d33684b1c15367c9e9be87e47840dbeab` | #4245 | #4245 |
| `feature/DL-14753` | `490f18ac2edbcc81ce83dd68c64f6cfbfd0a9839` | #4216 | #4216 |
| `feature/DL-14787` | `69b8f785410161dbb69212a689426d1613d6f289` | #4128 | #4128 |
| `feature/DL-14805-1` | `83bf00786c1381703616b67393d2fdb78d1fa45a` | #4193 | #4193 |
| `feature/DL-14805-1-3` | `d3b065f3c112aabd9db9d66af0e95e2221469e8e` | #4200 | #4200 |
| `feature/DL-14805-3` | `3526a79704c0840eb3aeba35cfad4746f7caca37` | #4221, #4220 | #4221 |
| `feature/DL-14805-e2e` | `ad0d08aaa3302c91d83dcd6aeedf4c930ee637d9` | #4190, #4181, #4122 | #4190 |
| `feature/DL-14809` | `f7d324f46b9f39821ca2343f7dfdebb227c88f4c` | #4168, #4165, #4162 | #4168 |
| `feature/DL-14890` | `f5806d1d5f82fbf336fb30ea5c7bda592d58a31f` | #4173, #4171 | #4173 |
| `feature/DL-14892` | `3879fb304bda5ab432297b09e5f7be06c6a6691f` | #4148 | #4148 |
| `feature/DL-14897` | `411df4204f0cae1402bfd2a0d324bc22d408c486` | #4145 | #4145 |
| `feature/DL-14989` | `b2674b5ea86b84b727df6c88d637166a0420ecca` | #4174 | #4174 |
| `feature/DL-14990` | `edab852b18dd761f26c097e2467394080929c84c` | #4175 | #4175 |
| `feature/DL-15010` | `5d6ecd02ef19b05e7446f7d3a824df23b8ddac10` | #4182 | #4182 |
| `feature/DL-15024` | `d95733a4ea66006aa9e2f5fc71373b5008828d92` | #4186 | #4186 |
| `feature/DL-15025` | `9f9b2d62f3c448c23178eb934ed0a87afcd359e5` | #4188 | #4188 |
| `feature/DL-15107` | `53455f8a2ce4d4d2bdc77d3d94fb55c86ca6ad64` | #4266, #4229, #4207 | #4266 |
| `feature/DL-15107-qa-1` | `b1f0c34a28e25ecf97a8c660e27fb36f2e29c9f3` | #4284 | #4284 |
| `feature/DL-15157` | `50c9134e4c0debc3f7cb4b17dd678cf12c88c56b` | #4218 | #4218 |
| `feature/DL-15157-2` | `92ce0be5e150b3216a560d73247b0a44f4c6269c` | #4262, #4261, #4260 | #4262 |
| `feature/DL-15157-3` | `9a69a2ef34ddc8b1a58f729b50cd5cb3b445785d` | #4271, #4270 | #4270 |
| `feature/DL-15157-qa-1` | `eca85eeb212810b5042c49d4bd0d18918b47d251` | #4228 | #4228 |
| `feature/DL-15170-qa-1` | `fb1a037449bce4f26fda236c85446ddf4f1559f4` | #4224 | #4224 |
| `feature/DL-15197` | `d754518db06149d66650df6c5802aefababa3e62` | #4282, #4281, #4279, #4278, #4258, #4250 | #4281 |
| `feature/DL-15197-fix` | `6ec3a81cbec5cd572855e68b48e2f0131ed2977b` | #4290 | #4290 |
| `feature/DL-15223` | `d324dc55970aa12e5cc3a367ca907d3feb2ff401` | #4470, #4469, #4459, #4443 | #4469 |
| `feature/DL-15223-advanced-export-limit-ui` | `3d1eba07c0093f572eb8094598f9039970725e0b` | #4505 | #4505 |
| `feature/DL-15223-lab-allocator-api` | `3f1c62d3cfbe3677d46b771122a629039d14c566` | #4493 | #4493 |
| `feature/DL-15255` | `3a677d48fa3f008a6ae218552521009b60073839` | #4268 | #4268 |
| `feature/DL-15287` | `09d025d210f3239a258df6be5de216e6628056ba` | #4285 | #4285 |
| `feature/DL-15328` | `2cba80a44ad23b603028157f05aef621a71c7cff` | #4286 | #4286 |
| `feature/DL-15369` | `5aa180befa7607cd9cce2e6abb45c1fb15c8d07b` | #4530 | #4530 |
| `feature/DL-15438` | `b9682ee27c626bdc3464995d367bf95a788c619a` | #4366, #4336 | #4366 |
| `feature/DL-15443` | `c24653c7a77f82d4b6fdc230f7e69f90e406d47d` | #4337 | #4337 |
| `feature/DL-15478` | `06c7277baae93d5c82ab8addef42792581e8e12d` | #4335 | #4335 |
| `feature/DL-15560` | `7b6808c643f61fb80d318403a041f489e1f64afe` | #4381 | #4381 |
| `feature/DL-15560-1` | `b61c2a1fc56410f9adf10a809caf6c98e0313060` | #4387 | #4387 |
| `feature/DL-15560-2` | `db98c8f24f548a3275e0cf8364972fecf0fd2954` | #4420 | #4420 |
| `feature/DL-15828` | `6b316e9820ed0c99637abb7906fb91dcc29502fc` | #4571, #4559, #4555, #4554 | #4555 |
| `feature/DL-15828-lab-e2e-i18n` | `8d4d0d1c12f023c8b7ce7542662d7daa7ab0bc34` | #4582 | #4582 |
| `feature/DL-15906-DL-15937` | `81aaf2d35d9ef9c8e25b2af1c06203c75ce151ee` | #4490 | #4490 |
| `feature/DL-15906-DL-15937-develop` | `8924d54bcf3b034a243c64131c797160a3d6aeb4` | #4491 | #4490 |
| `feature/DL-16002` | `5607fffd9cade46924650350a4f022bed2c6b584` | #4513 | #4513 |
| `feature/DL-16004` | `0ca8b9da6f09a06511894a1b4e8e29e6e7762c48` | #4512 | #4512 |
| `feature/DL-16135` | `195cc732e3a8b08ed16b7e6aa43c3a8e16ef3e47` | #4531 | #4531 |
| `feature/DL-16226` | `7d5455b59e764e6c68fe851c5ae51425a64c5e4f` | #4544 | #4544 |
| `feature/DL-16258` | `f7f81e69a2ccf29d8a72cf972b5f7a9d16e28806` | #4573, #4572, #4556 | #4573 |
| `feature/DL-16258-release-hold` | `af496bb345aa4ad28790de699156ebc9cc85635f` | #4567 | #4567 |
| `feature/DL-16258-warranty-policy-fix` | `75a0e18e2487c2f1b82838daa5724199b94af8fc` | #4576 | #4576 |
| `feature/DL-16269` | `be31e35967417b05de0b03fe1983d88fac7b6ac1` | #4558 | #4558 |
| `feature/DL-16443` | `1babe908fed7e9eceec6206213c7f6ed466c8613` | #4625 | #4625 |
| `feature/DL-16534` | `9aea3d0e036c63e850d940160344e8c51c814a79` | #4636 | #4636 |
| `feature/DL-16596` | `e2d33db83b0f11b4dd86891a86e58b275db683fa` | #4663 | #4663 |
| `feature/DL-16615` | `1b0c7a44d9d8f39c55e741c30c1521e4dad75e0e` | #4660 | #4660 |
| `feature/DL-16652` | `1c82980797fc0cf8e728f0aed77250e956336f8d` | #4665 | #4665 |
| `feature/DL-16652-hide-total-orders` | `d2d1abf55d977e4ab00c6fbaa7c6c9cd1f60e197` | #4686 | #4686 |
| `feature/DL-16655` | `80207a234332ad43f22b184b39213fb5d1a5d790` | #4675 | #4675 |
| `feature/dada-qa-04.06` | `57551e127af00615bb8d445765e1e37dbafec807` | #3924, #3919 | #3919 |
| `feature/dadan-final` | `fb7f8e2a277c848d29f280910fa947a0483a7e09` | #3927 | #3927 |
| `feature/dadan-qa` | `30a5c970ffd6f764ad37fa2f8e52f77b4ad6f2a3` | #3875 | #3875 |
| `feature/dadan-qa-03.31` | `46e82e4635436e3bed6361483151f85d1f3b9d07` | #3877 | #3877 |
| `feature/dadan-qa-04.01.2` | `3821667c7b3957ba135180e7463d379bbc9ac731` | #3892 | #3892 |
| `feature/dadan-qa-04.02.1` | `7a53c992ac45e84351d8b0d0a65bd44522068ad3` | #3902, #3901, #3900, #3899, #3894 | #3901 |
| `feature/dadan-qa-04.03.1` | `a5cd41319d11ce103321ae399b0075215750a1dd` | #3916, #3915, #3914, #3909, #3908, #3905, #3904, #3903 | #3916 |
| `feature/dadan-qa-04.03.2` | `405943086ee6aa8e53c6909e3c6a8220cb8b93c6` | #3917 | #3917 |
| `feature/dadan-qa-04061` | `abb91b6de7383be8b46f6fff9b9ea886779b2dce` | #3925, #3923, #3922, #3921 | #3925 |
| `feature/e2e-group-guide` | `48821fe9815f262637b0c7d853c3bc15beaa6b40` | #4648 | #4648 |
| `feature/e2e-reliability` | `f267c4924440cfd620edd0f92d92a36d48608a2b` | #4606 | #4606 |
| `feature/i18n` | `d14fa14354b7545c16f0e34094eb8ada649bb13a` | #4518, #4516, #4515, #4510, #4509, #4508, #4471, #4463, #4462, #4461, #4460 | #4518 |
| `feature/i18n-maintenance` | `095f503bc8a5fd6debc88e968ec07b615efb034e` | #4522 | #4522 |
| `feature/i18n-sheet-sync` | `d8e663c7ad20507c2f38360445938e4899d68b70` | #4536 | #4536 |
| `feature/i18n-sheet-workflow` | `eebf35db3d44cc3e4d586ab452e48baf70a58033` | #4557 | #4557 |
| `feature/lab-i18n-workflow` | `67e95af9f8b15bf251ec06ed063578941c97ebf5` | #4666 | #4666 |
| `feature/order-detail-product-type-cleanup` | `0881b8bae0615c758b7e9329139aec743ebd4ca1` | #4291 | #4291 |
| `feature/ui-requirements-audit` | `b57a4b014024b1f4a447cb7089d4e3309d8e4439` | #4642 | #4642 |
| `feature/v1.76.0-qa-1` | `afab900e780854bfff14251d375f2d613bfde451` | #4307 | #4307 |
| `feature/v1.76.0-qa-2` | `99087cff6b94854ff058a7de5e35eaabe8e2ead8` | #4309 | #4309 |
| `feature/v1.76.0-qa-3` | `60b1de8dd5d2aa75eb9ece38300e04fbf66a2aa1` | #4312 | #4312 |
| `feature/v1.76.0-qa-allonx` | `59918911a1c4302631a575a7725ce3a3f71f8a4b` | #4304 | #4304 |
| `feature/v1.79.0-qa` | `159703cf7847a0f21ee5b6dfce2af8a3e280e474` | #4414 | #4414 |
| `feature/v1.79.0-qa-2` | `04a09f881748e4b1b50d66f2f41a1c27abd9a911` | #4422 | #4422 |
| `feature/v1.83.0-follow-up` | `f2d348c3099e558c285257047a01e0f1c6b28703` | #4496 | #4496 |
| `feature/v1.83.0-qa` | `7295879db2280e2a18240c915801b2bb43e070b0` | #4488 | #4488 |
| `fix/DL-15828-e2e-staging-stability` | `c0f7f801d0a8422d1cf6f0f89894d67d97a3f3d7` | #4583 | #4583 |
| `fix/DL-15828-qa` | `0c7f95a64d2f9ca431fc49db91be3ed3c3144090` | #4585 | #4585 |
| `fix/DL-16385-order-feedback-reviewable` | `7a657b2bbe3033bedd81d20d852669ac419b441d` | #4600 | #4600 |
| `fix/clinic-e2e-scenario-update` | `455ed38268c35b1f988f6aba272f083871cf7459` | #4584 | #4584 |
| `hotfix/1.65.3` | `35fe2d8cf8d3e3ad2d612d6c1450f9215eb8bf22` | #3952, #3950, #3949, #3948, #3947 | #3952, #3949 |
| `hotfix/1.65.4` | `60bca5288c185d807b8c67892db99f76adcc96ae` | #3956 | #3956 |
| `hotfix/v1.65.2` | `c4b11083395a9ae8f37ce0ca0e80adf4419c76d2` | #3944, #3943, #3942 | #3944 |
| `hotfix/v1.71.3` | `563fdff9da245a8aaa1c09cddb02dd2aa8981266` | #4123 | #4123 |
| `codex/DL-14232-qa-followup-develop` | `ba0f61a1307757cc0145fc8e625119bd6580ef65` | #4397 | #4399 |
| `feature/DL-16443-develop-2` | `d188f68ad45a26dd3e3b2092caca69798d67abb0` | #4627 | #4625 |

### Preserved local branches and worktrees

| Branch | Observed SHA |
| --- | --- |
| `claude/pr-4700-review-f03f94` | `55ad768d54c3ffc9948f22051aad36ba49ba293c` |
| `feature/DL-16317` | `f4bfaf1bf102a555ec6350aee97ea0a1ab2c7d05` |
| `feature/DL-16387` | `347909945b091324e7134673525203de14e122fd` |
| `feature/DL-16387-develop-20261016` | `73082ae5ade30e1c33deb281abbe83039545ab7d` |
| `feature/DL-16466` | `56bc1be5ce975c6726637be51347911d730410ba` |
| `feature/DL-16471` | `12fb96a4e32c6a5e9abb4f61c235d9c2c1e53a14` |
| `feature/DL-16471-dlds-dlos-integration` | `fcbf17a9aedd88f29bee7f0925208dda7b0fc654` |
| `feature/DL-16796` | `3aac1dff0005706e78015cb5f23f255712696911` |
| `master` | `8772d68825cac6e23792d86a715153a67dc71078` |

All registered worktrees had no tracked or untracked changes.

- `/Users/parkjongsun/Repository/dentlink-client` - `feature/DL-16796`
- `/Users/parkjongsun/Repository/dentlink-client-dlds` - `feature/DL-16471`
- `/Users/parkjongsun/Repository/dentlink-client-dlds-integration` - `feature/DL-16471-dlds-dlos-integration`
- `/Users/parkjongsun/Repository/dentlink-client-permission` - `feature/DL-16317`
- `/Users/parkjongsun/Repository/dentlink-client/.claude/worktrees/pr-4700-review-f03f94` - `claude/pr-4700-review-f03f94`

## dentlink-app

### Deleted local items

No local branches deleted.

No worktrees removed.

### Deleted remote branches

| Branch | Previous SHA | Owner/source PR | Released PR |
| --- | --- | --- | --- |
| `feature/DL-16652` | `81584b8201edffd00b2261aaa5d7322be493bd1e` | #318 | #318 |

### Preserved local branches and worktrees

| Branch | Observed SHA |
| --- | --- |
| `feature/DL-16317` | `df3c79a5efa51e9c9160c9f0d6d260be93310584` |
| `main` | `a32aa691199db8c7c0d866af0293a6b9970d8a8d` |

All registered worktrees had no tracked or untracked changes.

- `/Users/parkjongsun/Repository/dentlink-app` - `main`
- `/Users/parkjongsun/Repository/dentlink-app-permission` - `feature/DL-16317`

## dentlink-lab-app

### Deleted local items

| Branch | Previous SHA |
| --- | --- |
| `feature/lab-i18n-workflow` | `5844ba5348901aa435ef522e47f5f1d91e00de86` |
| `feature/lab-i18n-workflow-release` | `9e04b395275a870bf3bf74b42c155eafb9f41d89` |
| `backup/lab-dl16652-before-release-sync-20261008` | `e3bf33567c5fde6e526e38b237d2b21f416b4476` |

Removed worktree: `/Users/parkjongsun/Repository/dentlink-lab-app-i18n-release`.

### Deleted remote branches

| Branch | Previous SHA | Owner/source PR | Released PR |
| --- | --- | --- | --- |
| `QA/lab/DL-16652-hide-total-orders` | `e6c4f89eca1f547455086b263a15f12a4b555cb0` | #13 | #5/#6/#8/#13 -> #14 |
| `QA/lab/DL-16652-review-icon` | `bb2df333e102b96286eb37b01d48cdb529adeef0` | #8 | #5/#6/#8/#13 -> #14 |
| `feature/DL-16652` | `14949c6afd77530852c166b317a667f4b30dd049` | #2, #6 | #5/#6/#8/#13 -> #14 |
| `feature/lab-i18n-workflow` | `5844ba5348901aa435ef522e47f5f1d91e00de86` | #3, #5 | #5/#6/#8/#13 -> #14 |
| `feature/lab-i18n-workflow-release` | `9e04b395275a870bf3bf74b42c155eafb9f41d89` | #5 | #5/#6/#8/#13 -> #14 |
| `feature/lab/DL-16652-release` | `55bc14377104b294a424d30a5fe135c946e2655d` | #6 | #5/#6/#8/#13 -> #14 |

### Preserved local branches and worktrees

| Branch | Observed SHA |
| --- | --- |
| `main` | `bb619010b25419b724a5f6acded6f5760bb9af15` |

All registered worktrees had no tracked or untracked changes.

- `/Users/parkjongsun/Repository/dentlink-lab-app` - `main`
