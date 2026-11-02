<<>> F deadlock: false
0- RootNode  initial - # Children: 0
Valuation: {x = -5.0   y = -5.0   dir_x = 0.0   dir_y = 0.0   shooter = 0.0   }




***************************
***************************
***************************


<<A,B,C,D>> G ! deadlock: true
0- RootNode  initial - # Children: 1
Valuation: {x = -5.0   y = -5.0   dir_x = 0.0   dir_y = 0.0   shooter = 0.0   }

0- TriggerNode initial - Time: 0.0 - Agent: A - Trigger: (((x == -5.0)) && ((y == -5.0))) && ((shooter != 1.0)) - # Children: 1
Valuation: {x = -5.0   y = -5.0   dir_x = 0.0   dir_y = 0.0   shooter = 0.0   }

	1- DecisionNode A_Throwing - Time: 0.0 - Agent: A - Action: R - # Children: 1
	Valuation: {x = -5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

		2- TriggerNode A_Throwing - Time: 10.0 - Agent: B - Trigger: (((x == 5.0)) && ((y == -5.0))) && ((shooter != 2.0)) - # Children: 1
		Valuation: {x = 5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

			3- DecisionNode B_Throwing - Time: 10.0 - Agent: B - Action: R - # Children: 1
			Valuation: {x = 5.0   y = -5.0   dir_x = 0.0   dir_y = 1.0   shooter = 2.0   }

				4- TriggerNode B_Throwing - Time: 20.0 - Agent: C - Trigger: (((x == 5.0)) && ((y == 5.0))) && ((shooter != 3.0)) - # Children: 1
				Valuation: {x = 5.0   y = 5.0   dir_x = 0.0   dir_y = 1.0   shooter = 2.0   }

					5- DecisionNode C_Throwing - Time: 20.0 - Agent: C - Action: R - # Children: 1
					Valuation: {x = 5.0   y = 5.0   dir_x = -1.0   dir_y = 0.0   shooter = 3.0   }

						6- TriggerNode C_Throwing - Time: 30.0 - Agent: D - Trigger: (((x == -5.0)) && ((y == 5.0))) && ((shooter != 4.0)) - # Children: 1
						Valuation: {x = -5.0   y = 5.0   dir_x = -1.0   dir_y = 0.0   shooter = 3.0   }

							7- DecisionNode D_Throwing - Time: 30.0 - Agent: D - Action: R - # Children: 1
							Valuation: {x = -5.0   y = 5.0   dir_x = 0.0   dir_y = -1.0   shooter = 4.0   }

								8- TriggerNode D_Throwing - Time: 40.0 - Agent: A - Trigger: (((x == -5.0)) && ((y == -5.0))) && ((shooter != 1.0)) - # Children: 1
								Valuation: {x = -5.0   y = -5.0   dir_x = 0.0   dir_y = -1.0   shooter = 4.0   }

									9- DecisionNode A_Throwing - Time: 40.0 - Agent: A - Action: R - # Children: 1
									Valuation: {x = -5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

										10- TriggerNode A_Throwing - Time: 50.0 - Agent: B - Trigger: (((x == 5.0)) && ((y == -5.0))) && ((shooter != 2.0)) - # Children: 1
										Valuation: {x = 5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

											11- DecisionNode B_Throwing - Time: 50.0 - Agent: B - Action: R - # Children: 1
											Valuation: {x = 5.0   y = -5.0   dir_x = 0.0   dir_y = 1.0   shooter = 2.0   }

												12- TriggerNode B_Throwing - Time: 60.0 - Agent: C - Trigger: (((x == 5.0)) && ((y == 5.0))) && ((shooter != 3.0)) - # Children: 1
												Valuation: {x = 5.0   y = 5.0   dir_x = 0.0   dir_y = 1.0   shooter = 2.0   }

													13- DecisionNode C_Throwing - Time: 60.0 - Agent: C - Action: R - # Children: 1
													Valuation: {x = 5.0   y = 5.0   dir_x = -1.0   dir_y = 0.0   shooter = 3.0   }

														14- TriggerNode C_Throwing - Time: 70.0 - Agent: D - Trigger: (((x == -5.0)) && ((y == 5.0))) && ((shooter != 4.0)) - # Children: 1
														Valuation: {x = -5.0   y = 5.0   dir_x = -1.0   dir_y = 0.0   shooter = 3.0   }

															15- DecisionNode D_Throwing - Time: 70.0 - Agent: D - Action: R - # Children: 1
															Valuation: {x = -5.0   y = 5.0   dir_x = 0.0   dir_y = -1.0   shooter = 4.0   }

																16- TriggerNode D_Throwing - Time: 80.0 - Agent: A - Trigger: (((x == -5.0)) && ((y == -5.0))) && ((shooter != 1.0)) - # Children: 1
																Valuation: {x = -5.0   y = -5.0   dir_x = 0.0   dir_y = -1.0   shooter = 4.0   }

																	17- DecisionNode A_Throwing - Time: 80.0 - Agent: A - Action: R - # Children: 1
																	Valuation: {x = -5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

																		18- TriggerNode A_Throwing - Time: 90.0 - Agent: B - Trigger: (((x == 5.0)) && ((y == -5.0))) && ((shooter != 2.0)) - # Children: 1
																		Valuation: {x = 5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

																			19- DecisionNode B_Throwing - Time: 90.0 - Agent: B - Action: R - # Children: 1
																			Valuation: {x = 5.0   y = -5.0   dir_x = 0.0   dir_y = 1.0   shooter = 2.0   }

																				20- TriggerNode B_Throwing - Time: 100.0 - Agent: C - Trigger: (((x == 5.0)) && ((y == 5.0))) && ((shooter != 3.0)) - # Children: 1
																				Valuation: {x = 5.0   y = 5.0   dir_x = 0.0   dir_y = 1.0   shooter = 2.0   }

																					21- DecisionNode C_Throwing - Time: 100.0 - Agent: C - Action: R - # Children: 1
																					Valuation: {x = 5.0   y = 5.0   dir_x = -1.0   dir_y = 0.0   shooter = 3.0   }

																						22- TriggerNode C_Throwing - Time: 110.0 - Agent: D - Trigger: (((x == -5.0)) && ((y == 5.0))) && ((shooter != 4.0)) - # Children: 1
																						Valuation: {x = -5.0   y = 5.0   dir_x = -1.0   dir_y = 0.0   shooter = 3.0   }

																							23- DecisionNode D_Throwing - Time: 110.0 - Agent: D - Action: R - # Children: 1
																							Valuation: {x = -5.0   y = 5.0   dir_x = 0.0   dir_y = -1.0   shooter = 4.0   }

																								24- TriggerNode D_Throwing - Time: 120.0 - Agent: A - Trigger: (((x == -5.0)) && ((y == -5.0))) && ((shooter != 1.0)) - # Children: 1
																								Valuation: {x = -5.0   y = -5.0   dir_x = 0.0   dir_y = -1.0   shooter = 4.0   }

																									25- DecisionNode A_Throwing - Time: 120.0 - Agent: A - Action: R - # Children: 1
																									Valuation: {x = -5.0   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }

																										26- TerminalNode - A_Throwing - Time: 120.0
																										Valuation: {x = -4.99997   y = -5.0   dir_x = 1.0   dir_y = 0.0   shooter = 1.0   }




***************************
***************************
***************************


