<<A>> F y > 6: false
0- RootNode  B_Catch - # Children: 0
Valuation: {x = -10.0   y = 0.0   dir_x = 0.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }




***************************
***************************
***************************


<<B, C>> G y <= 2: true
0- RootNode  B_Catch - # Children: 1
Valuation: {x = -10.0   y = 0.0   dir_x = 0.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

0- TriggerNode B_Catch - Time: 0.0 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
Valuation: {x = -10.0   y = 0.0   dir_x = 0.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

	1- DecisionNode B_Throwing - Time: 0.0 - Agent: B - Action: R - # Children: 1
	Valuation: {x = -10.0   y = 0.0   dir_x = 20.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

		2- TriggerNode B_Throwing - Time: 5.25 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
		Valuation: {x = 10.9999   y = 0.0   dir_x = 20.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.24998   }

			3- DecisionNode C_Catch - Time: 5.25 - Agent: C - Action: Catch - # Children: 1
			Valuation: {x = 10.9999   y = 0.0   dir_x = 20.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

				4- TriggerNode C_Catch - Time: 5.25 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
				Valuation: {x = 10.9999   y = 0.0   dir_x = 20.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

					5- DecisionNode C_Throwing - Time: 5.25 - Agent: C - Action: L - # Children: 1
					Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

						6- TriggerNode C_Throwing - Time: 7.869 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
						Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

							7- DecisionNode B_Catch - Time: 7.869 - Agent: B - Action: Catch - # Children: 1
							Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

								8- TriggerNode B_Catch - Time: 7.869 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
								Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

									9- DecisionNode B_Throwing - Time: 7.869 - Agent: B - Action: R - # Children: 1
									Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

										10- TriggerNode B_Throwing - Time: 13.1071 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
										Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

											11- DecisionNode C_Catch - Time: 13.1071 - Agent: C - Action: Catch - # Children: 1
											Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

												12- TriggerNode C_Catch - Time: 13.1071 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
												Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

													13- DecisionNode C_Throwing - Time: 13.1071 - Agent: C - Action: L - # Children: 1
													Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

														14- TriggerNode C_Throwing - Time: 15.7261 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
														Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

															15- DecisionNode B_Catch - Time: 15.7261 - Agent: B - Action: Catch - # Children: 1
															Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																16- TriggerNode B_Catch - Time: 15.7261 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																	17- DecisionNode B_Throwing - Time: 15.7261 - Agent: B - Action: R - # Children: 1
																	Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																		18- TriggerNode B_Throwing - Time: 20.9642 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																		Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

																			19- DecisionNode C_Catch - Time: 20.9642 - Agent: C - Action: Catch - # Children: 1
																			Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																				20- TriggerNode C_Catch - Time: 20.9642 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																				Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																					21- DecisionNode C_Throwing - Time: 20.9642 - Agent: C - Action: L - # Children: 1
																					Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																						22- TriggerNode C_Throwing - Time: 23.5832 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																						Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

																							23- DecisionNode B_Catch - Time: 23.5832 - Agent: B - Action: Catch - # Children: 1
																							Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																								24- TriggerNode B_Catch - Time: 23.5832 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																								Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																									25- DecisionNode B_Throwing - Time: 23.5832 - Agent: B - Action: R - # Children: 1
																									Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																										26- TriggerNode B_Throwing - Time: 28.8213 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																										Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

																											27- DecisionNode C_Catch - Time: 28.8213 - Agent: C - Action: Catch - # Children: 1
																											Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																												28- TriggerNode C_Catch - Time: 28.8213 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																												Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																													29- DecisionNode C_Throwing - Time: 28.8213 - Agent: C - Action: L - # Children: 1
																													Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																														30- TriggerNode C_Throwing - Time: 31.4403 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																														Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

																															31- DecisionNode B_Catch - Time: 31.4403 - Agent: B - Action: Catch - # Children: 1
																															Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																32- TriggerNode B_Catch - Time: 31.4403 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																	33- DecisionNode B_Throwing - Time: 31.4403 - Agent: B - Action: R - # Children: 1
																																	Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																		34- TriggerNode B_Throwing - Time: 36.6784 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																		Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

																																			35- DecisionNode C_Catch - Time: 36.6784 - Agent: C - Action: Catch - # Children: 1
																																			Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																				36- TriggerNode C_Catch - Time: 36.6784 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																				Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																					37- DecisionNode C_Throwing - Time: 36.6784 - Agent: C - Action: L - # Children: 1
																																					Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																						38- TriggerNode C_Throwing - Time: 39.2975 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																						Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

																																							39- DecisionNode B_Catch - Time: 39.2975 - Agent: B - Action: Catch - # Children: 1
																																							Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																								40- TriggerNode B_Catch - Time: 39.2975 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																								Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																									41- DecisionNode B_Throwing - Time: 39.2975 - Agent: B - Action: R - # Children: 1
																																									Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																										42- TriggerNode B_Throwing - Time: 44.5355 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																										Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

																																											43- DecisionNode C_Catch - Time: 44.5355 - Agent: C - Action: Catch - # Children: 1
																																											Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																												44- TriggerNode C_Catch - Time: 44.5355 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																												Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																													45- DecisionNode C_Throwing - Time: 44.5355 - Agent: C - Action: L - # Children: 1
																																													Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																														46- TriggerNode C_Throwing - Time: 47.1546 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																														Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

																																															47- DecisionNode B_Catch - Time: 47.1546 - Agent: B - Action: Catch - # Children: 1
																																															Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																48- TriggerNode B_Catch - Time: 47.1546 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																																Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																	49- DecisionNode B_Throwing - Time: 47.1546 - Agent: B - Action: R - # Children: 1
																																																	Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																		50- TriggerNode B_Throwing - Time: 52.3926 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																																		Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

																																																			51- DecisionNode C_Catch - Time: 52.3926 - Agent: C - Action: Catch - # Children: 1
																																																			Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																				52- TriggerNode C_Catch - Time: 52.3926 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																																				Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																					53- DecisionNode C_Throwing - Time: 52.3926 - Agent: C - Action: L - # Children: 1
																																																					Valuation: {x = 10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																						54- TriggerNode C_Throwing - Time: 55.0117 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																																						Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 2.61904   }

																																																							55- DecisionNode B_Catch - Time: 55.0117 - Agent: B - Action: Catch - # Children: 1
																																																							Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																								56- TriggerNode B_Catch - Time: 55.0117 - Agent: B - Trigger: ((((x - B_x) ^ 2.0) + ((y - B_y) ^ 2.0)) <= 1.0) - # Children: 1
																																																								Valuation: {x = -10.9999   y = 0.0   dir_x = -20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																									57- DecisionNode B_Throwing - Time: 55.0117 - Agent: B - Action: R - # Children: 1
																																																									Valuation: {x = -10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																										58- TriggerNode B_Throwing - Time: 60.2497 - Agent: C - Trigger: ((((x - C_x) ^ 2.0) + ((y - C_y) ^ 2.0)) <= 1.0) - # Children: 1
																																																										Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 5.23807   }

																																																											59- DecisionNode C_Catch - Time: 60.2497 - Agent: C - Action: Catch - # Children: 1
																																																											Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }

																																																												60- TerminalNode - C_Catch - Time: 60.2497
																																																												Valuation: {x = 10.9999   y = 0.0   dir_x = 20.9999   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }




***************************
***************************
***************************


<<B>> G y <= 2: false
0- RootNode  B_Catch - # Children: 0
Valuation: {x = -10.0   y = 0.0   dir_x = 0.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }




***************************
***************************
***************************


<<>> F deadlock: false
0- RootNode  B_Catch - # Children: 0
Valuation: {x = -10.0   y = 0.0   dir_x = 0.0   dir_y = 0.0   spd_A = 0.1   spd_B = 0.2   spd_C = 0.4   A_x = 0.0   A_y = 10.0   B_x = -10.0   B_y = 0.0   C_x = 10.0   C_y = 0.0   time = 0.0   }




***************************
***************************
***************************


