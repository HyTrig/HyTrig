<<cop_0 >> F ((cop_0_x == robber_x)) && ((cop_0_y == robber_y)): False
Evaluation Time = 4.4003
<<robber >> G !(((cop_0_x == robber_x)) && ((cop_0_y == robber_y))): True
Nodes = 294 - Tree Depth = 32 - Max Game Time = 90.0
Evaluation Time = 3.1408

<<cop_0>> F ((cop_0_x == robber_x && cop_0_y == robber_y)): false
0- RootNode  running - # Children: 1
Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }

0- TriggerNode running - Time: 0.0 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }

	1- DecisionNode running - Time: 0.0 - Agent: robber - Action: v4 - # Children: 1
	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

		2- TriggerNode running - Time: 3.0 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 2
		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

			3- DecisionNode running - Time: 3.0 - Agent: robber - Action: v2 - # Children: 1
			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

				4- TriggerNode running - Time: 3.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

					5- DecisionNode running - Time: 3.0 - Agent: cop_0 - Action: v0 - # Children: 1
					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

						6- TriggerNode running - Time: 4.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 1
						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 1.5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

							7- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v2 - # Children: 2
							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 1.5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

								8- TriggerNode running - Time: 6.0 - Agent: robber - Trigger: ((((target_robber_x == v2_x)) && ((target_robber_y == v2_y))) && ((robber_x == v2_x))) && ((robber_y == v2_y)) - # Children: 3
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

									9- DecisionNode running - Time: 6.0 - Agent: robber - Action: v0 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = -3.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

										10- PropertyNode - running - Time: 6.0
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -1.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 0.0   robber_y = -0.0   target_robber_x = -3.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

									9- DecisionNode running - Time: 6.0 - Agent: robber - Action: v3 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = -1.0e-5   robber_dir_y = 1.0   }

										10- PropertyNode - running - Time: 6.0
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = 3.0e-5   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = -1.0e-5   robber_dir_y = 1.0   }

									9- DecisionNode running - Time: 6.0 - Agent: robber - Action: v4 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

										10- TriggerNode running - Time: 6.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 7.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

											11- DecisionNode running - Time: 6.0 - Agent: cop_0 - Action: v4 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 7.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

												12- PropertyNode - running - Time: 6.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 6.0e-5   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 0.0001   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

								8- PropertyNode - running - Time: 6.0
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -1.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 0.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

			3- DecisionNode running - Time: 3.0 - Agent: robber - Action: v5 - # Children: 1
			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

				4- TriggerNode running - Time: 6.0 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

					5- DecisionNode running - Time: 6.0 - Agent: robber - Action: v4 - # Children: 1
					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

						6- TriggerNode running - Time: 9.0 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 2
						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

							7- DecisionNode running - Time: 9.0 - Agent: robber - Action: v2 - # Children: 1
							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

								8- TriggerNode running - Time: 9.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

									9- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v0 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

										10- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 1
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 1.5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

											11- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 2
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 1.5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

												12- TriggerNode running - Time: 12.0 - Agent: robber - Trigger: ((((target_robber_x == v2_x)) && ((target_robber_y == v2_y))) && ((robber_x == v2_x))) && ((robber_y == v2_y)) - # Children: 3
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

													13- DecisionNode running - Time: 12.0 - Agent: robber - Action: v0 - # Children: 1
													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = -3.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

														14- PropertyNode - running - Time: 12.0
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -1.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 0.0   robber_y = -0.0   target_robber_x = -3.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

													13- DecisionNode running - Time: 12.0 - Agent: robber - Action: v3 - # Children: 1
													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = -1.0e-5   robber_dir_y = 1.0   }

														14- PropertyNode - running - Time: 12.0
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = 3.0e-5   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = -1.0e-5   robber_dir_y = 1.0   }

													13- DecisionNode running - Time: 12.0 - Agent: robber - Action: v4 - # Children: 1
													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -7.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

														14- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 7.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

															15- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
															Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 7.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

																16- PropertyNode - running - Time: 12.0
																Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 6.0e-5   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 0.0001   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

												12- PropertyNode - running - Time: 12.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -1.0e-5   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 0.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

							7- DecisionNode running - Time: 9.0 - Agent: robber - Action: v5 - # Children: 1
							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

								8- TriggerNode running - Time: 12.0 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

									9- DecisionNode running - Time: 12.0 - Agent: robber - Action: v4 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

										10- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

											11- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

												12- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 1
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

													13- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 2
													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

														14- TriggerNode running - Time: 15.0 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 2
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

															15- DecisionNode running - Time: 15.0 - Agent: robber - Action: v2 - # Children: 1
															Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

																16- TriggerNode running - Time: 15.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
																Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 2.99995   robber_y = 5.0e-5   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

																	17- DecisionNode running - Time: 15.0 - Agent: cop_0 - Action: v0 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 2.99995   robber_y = 5.0e-5   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

																		18- TriggerNode running - Time: 16.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 1.49995   robber_y = 2.0e-5   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

																			19- DecisionNode running - Time: 16.5 - Agent: cop_0 - Action: v2 - # Children: 2
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 1.49995   robber_y = 2.0e-5   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

																				20- TriggerNode running - Time: 17.9999 - Agent: robber - Trigger: ((((target_robber_x == v2_x)) && ((target_robber_y == v2_y))) && ((robber_x == v2_x))) && ((robber_y == v2_y)) - # Children: 3
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -0.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

																					21- DecisionNode running - Time: 17.9999 - Agent: robber - Action: v0 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -0.0   robber_y = -0.0   target_robber_x = -3.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

																						22- PropertyNode - running - Time: 18.0
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -4.0e-5   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -4.0e-5   robber_y = -0.0   target_robber_x = -3.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

																					21- DecisionNode running - Time: 17.9999 - Agent: robber - Action: v3 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -0.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 18.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -0.0   robber_y = 5.0e-5   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 18.0 - Agent: cop_0 - Action: v3 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = -0.0   robber_y = 5.0e-5   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- PropertyNode - running - Time: 18.0001
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0001   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = -0.0   robber_y = 0.0001   target_robber_x = 0.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																					21- DecisionNode running - Time: 17.9999 - Agent: robber - Action: v4 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -0.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

																						22- PropertyNode - running - Time: 18.0
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 5.0e-5   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 1.0   robber_dir_y = 0.0   }

																				20- PropertyNode - running - Time: 18.0
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -4.0e-5   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = -4.0e-5   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = -2.0e-5   }

															15- DecisionNode running - Time: 15.0 - Agent: robber - Action: v5 - # Children: 1
															Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																16- TriggerNode running - Time: 15.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
																Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																	17- DecisionNode running - Time: 15.0 - Agent: cop_0 - Action: v3 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																		18- TriggerNode running - Time: 16.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																			19- DecisionNode running - Time: 16.5 - Agent: cop_0 - Action: v2 - # Children: 1
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- TriggerNode running - Time: 17.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.00021   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																					21- DecisionNode running - Time: 17.9999 - Agent: robber - Action: v4 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.00021   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																						22- TriggerNode running - Time: 18.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 2.0e-5   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 18.0 - Agent: cop_0 - Action: v4 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 2.0e-5   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -1.0e-5   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																								24- TriggerNode running - Time: 19.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -1.0e-5   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																									25- DecisionNode running - Time: 19.5 - Agent: cop_0 - Action: v5 - # Children: 1
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- PropertyNode - running - Time: 20.0
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.99993   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.99993   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

														14- TriggerNode running - Time: 15.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 1
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

															15- DecisionNode running - Time: 15.0 - Agent: cop_0 - Action: v4 - # Children: 1
															Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																16- TriggerNode running - Time: 15.0 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 2
																Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																	17- DecisionNode running - Time: 15.0 - Agent: robber - Action: v2 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

																		18- PropertyNode - running - Time: 16.0
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 2.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 2.0   robber_y = -0.0   target_robber_x = 0.0   target_robber_y = 0.0   robber_dir_x = -1.0   robber_dir_y = 0.0   }

																	17- DecisionNode running - Time: 15.0 - Agent: robber - Action: v5 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																		18- TriggerNode running - Time: 16.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49999   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																			19- DecisionNode running - Time: 16.5 - Agent: cop_0 - Action: v5 - # Children: 1
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49999   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- PropertyNode - running - Time: 17.9999
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 2.9999   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99994   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }




***************************
***************************
***************************


<<robber>> G ! ((cop_0_x == robber_x && cop_0_y == robber_y)): true
0- RootNode  running - # Children: 2
Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }

0- TriggerNode running - Time: 0.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }

	1- DecisionNode running - Time: 0.0 - Agent: cop_0 - Action: v0 - # Children: 1
	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }

		2- TriggerNode running - Time: 0.0 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }

			3- DecisionNode running - Time: 0.0 - Agent: robber - Action: v4 - # Children: 1
			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

				4- TriggerNode running - Time: 1.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

					5- DecisionNode running - Time: 1.5 - Agent: cop_0 - Action: v1 - # Children: 1
					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

						6- TriggerNode running - Time: 3.0 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 1
						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.9999   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

							7- DecisionNode running - Time: 3.0 - Agent: robber - Action: v5 - # Children: 1
							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.9999   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

								8- TriggerNode running - Time: 3.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

									9- DecisionNode running - Time: 3.0 - Agent: cop_0 - Action: v0 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

										10- TriggerNode running - Time: 4.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v1 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- TriggerNode running - Time: 5.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.9998   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

													13- DecisionNode running - Time: 5.9999 - Agent: robber - Action: v4 - # Children: 1
													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.9998   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

														14- TriggerNode running - Time: 6.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

															15- DecisionNode running - Time: 6.0 - Agent: cop_0 - Action: v0 - # Children: 1
															Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																16- TriggerNode running - Time: 7.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																	17- DecisionNode running - Time: 7.5 - Agent: cop_0 - Action: v1 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																		18- TriggerNode running - Time: 8.9999 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99979   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																			19- DecisionNode running - Time: 8.9999 - Agent: robber - Action: v5 - # Children: 2
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99979   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- TriggerNode running - Time: 9.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99998   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v0 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99998   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v1 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99981   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99981   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 12.0
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00017   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00017   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 13.5
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																				20- Deadlock - running - Time: 9.0
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.00011   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																	17- DecisionNode running - Time: 7.5 - Agent: cop_0 - Action: v2 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																		18- TriggerNode running - Time: 8.9999 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00019   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																			19- DecisionNode running - Time: 8.9999 - Agent: robber - Action: v5 - # Children: 2
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00019   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = -0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- TriggerNode running - Time: 9.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 9.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v0 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 9.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v1 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99981   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 1
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99981   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00019   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00019   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 13.5
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v3 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 9.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.00019   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 1
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.00019   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v4 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 9.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.00019   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.00019   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 13.5
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v5 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- Deadlock - running - Time: 12.0
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 2.9999   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.00004   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- Deadlock - running - Time: 10.5
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v2 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- Deadlock - running - Time: 6.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.00005   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

					5- DecisionNode running - Time: 1.5 - Agent: cop_0 - Action: v2 - # Children: 1
					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

						6- TriggerNode running - Time: 3.0 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 1
						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

							7- DecisionNode running - Time: 3.0 - Agent: robber - Action: v5 - # Children: 2
							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 5.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

								8- TriggerNode running - Time: 3.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

									9- DecisionNode running - Time: 3.0 - Agent: cop_0 - Action: v0 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

										10- TriggerNode running - Time: 4.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v1 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- TriggerNode running - Time: 5.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.9998   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

													13- DecisionNode running - Time: 5.9999 - Agent: robber - Action: v4 - # Children: 1
													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.9998   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

														14- TriggerNode running - Time: 6.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99999   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

															15- DecisionNode running - Time: 6.0 - Agent: cop_0 - Action: v0 - # Children: 1
															Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99999   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																16- TriggerNode running - Time: 7.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																	17- DecisionNode running - Time: 7.5 - Agent: cop_0 - Action: v1 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																		18- TriggerNode running - Time: 8.9999 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99982   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																			19- DecisionNode running - Time: 8.9999 - Agent: robber - Action: v5 - # Children: 2
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99982   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- TriggerNode running - Time: 9.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 9.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v0 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 9.0e-5   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v1 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99982   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 1
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99982   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00017   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00017   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 13.5
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																				20- Deadlock - running - Time: 9.0
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.00002   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																	17- DecisionNode running - Time: 7.5 - Agent: cop_0 - Action: v2 - # Children: 1
																	Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																		18- TriggerNode running - Time: 8.9999 - Agent: robber - Trigger: ((((target_robber_x == v4_x)) && ((target_robber_y == v4_y))) && ((robber_x == v4_x))) && ((robber_y == v4_y)) - # Children: 1
																		Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00019   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 0.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																			19- DecisionNode running - Time: 8.9999 - Agent: robber - Action: v5 - # Children: 2
																			Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.00019   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 0.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- TriggerNode running - Time: 9.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v0 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v1 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99981   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 1
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 2.99981   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v1_x)) && ((target_cop_0_y == v1_y))) && ((cop_0_x == v1_x))) && ((cop_0_y == v1_y)) - # Children: 1
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0002   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0002   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.4999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 13.5
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.49989   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v3 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.00019   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.00019   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 12.0
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -2.0e-5   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 2.9999   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																					21- DecisionNode running - Time: 9.0 - Agent: cop_0 - Action: v4 - # Children: 1
																					Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																						22- TriggerNode running - Time: 10.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																						Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v2 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- TriggerNode running - Time: 11.9999 - Agent: robber - Trigger: ((((target_robber_x == v5_x)) && ((target_robber_y == v5_y))) && ((robber_x == v5_x))) && ((robber_y == v5_y)) - # Children: 1
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.00018   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																									25- DecisionNode running - Time: 11.9999 - Agent: robber - Action: v4 - # Children: 2
																									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.00018   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- TriggerNode running - Time: 12.0 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v2_x)) && ((target_cop_0_y == v2_y))) && ((cop_0_x == v2_x))) && ((cop_0_y == v2_y)) - # Children: 3
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v0 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v0_x)) && ((target_cop_0_y == v0_y))) && ((cop_0_x == v0_x))) && ((cop_0_y == v0_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v1 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v3 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																											27- DecisionNode running - Time: 12.0 - Agent: cop_0 - Action: v4 - # Children: 1
																											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 2.99991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																												28- TriggerNode running - Time: 13.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
																												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v2 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																													29- DecisionNode running - Time: 13.5 - Agent: cop_0 - Action: v5 - # Children: 1
																													Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																														30- TerminalNode - running - Time: 13.5
																														Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.49992   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																										26- Deadlock - running - Time: 13.5
																										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.49991   target_robber_x = 3.0   target_robber_y = 0.0   robber_dir_x = 0.0   robber_dir_y = -1.0   }

																							23- DecisionNode running - Time: 10.5 - Agent: cop_0 - Action: v5 - # Children: 1
																							Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																								24- Deadlock - running - Time: 11.9999
																								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 2.9999   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.00005   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

																				20- Deadlock - running - Time: 10.5
																				Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.50009   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v2 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- Deadlock - running - Time: 6.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.00005   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

									9- DecisionNode running - Time: 3.0 - Agent: cop_0 - Action: v3 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

										10- TriggerNode running - Time: 4.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v3_x)) && ((target_cop_0_y == v3_y))) && ((cop_0_x == v3_x))) && ((cop_0_y == v3_y)) - # Children: 1
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v2 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 3.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- Deadlock - running - Time: 6.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0001   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -0.0   cop_0_dir_y = -1.0   robber_x = 3.0   robber_y = 3.00005   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

									9- DecisionNode running - Time: 3.0 - Agent: cop_0 - Action: v4 - # Children: 1
									Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0   cop_0_y = 0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 0.0001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

										10- TriggerNode running - Time: 4.5 - Agent: cop_0 - Trigger: ((((target_cop_0_x == v4_x)) && ((target_cop_0_y == v4_y))) && ((cop_0_x == v4_x))) && ((cop_0_y == v4_y)) - # Children: 2
										Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = -0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v2 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- Deadlock - running - Time: 6.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 0.0001   cop_0_y = -0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = -1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.00005   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

											11- DecisionNode running - Time: 4.5 - Agent: cop_0 - Action: v5 - # Children: 1
											Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = -0.0   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

												12- Deadlock - running - Time: 6.0
												Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 2.9999   target_cop_0_x = 3.0   target_cop_0_y = 3.0   cop_0_dir_x = -0.0   cop_0_dir_y = 1.0   robber_x = 3.0   robber_y = 3.00005   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

								8- Deadlock - running - Time: 4.5
								Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = 3.0   cop_0_y = 0.0   target_cop_0_x = 0.0   target_cop_0_y = 0.0   cop_0_dir_x = 1.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 1.5001   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 1.0   }

0- TerminalNode - running - Time: 90.0
Valuation: {v0_x = -3.0   v0_y = 0.0   v1_x = -3.0   v1_y = 3.0   v2_x = 0.0   v2_y = 0.0   v3_x = 0.0   v3_y = 3.0   v4_x = 3.0   v4_y = 0.0   v5_x = 3.0   v5_y = 3.0   cop_speed = 2.0   robber_speed = 1.0   cop_0_x = -3.0   cop_0_y = 3.0   target_cop_0_x = -3.0   target_cop_0_y = 3.0   cop_0_dir_x = 0.0   cop_0_dir_y = 0.0   robber_x = 3.0   robber_y = 3.0   target_robber_x = 3.0   target_robber_y = 3.0   robber_dir_x = 0.0   robber_dir_y = 0.0   }




***************************
***************************
***************************


